//
//  AttachmentManager.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 27.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class AttachmentManager: AttachmentManagerProtocol {
    internal func uploadImage(image: UIImage!, attachableId: Int!, attachableType: String!, success: @escaping (_ attachment: Attachment) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        Alamofire.upload(multipartFormData: { formData in
            let imageData = UIImageJPEGRepresentation(image! as! UIImage, 0.9)!
            let tix = Date().ticks
            let imageName = "\(tix)"
            formData.append(imageData, withName: "file", fileName: imageName, mimeType: "image/jpg")
            formData.append((String(attachableType)?.data(using: String.Encoding.utf8))!, withName: "attachable_type")
            formData.append(String(attachableId).data(using: String.Encoding.utf8)!, withName: "attachable_id")
        }, to: "\(ApiRequest.sharedInstance.host)/api/v1/attachments", encodingCompletion: { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.validate().responseJSON(completionHandler: { response in
                    if let result = response.result.value {
                        let JSON = result as! Dictionary<String, AnyObject>
                        let attachment = Mapper<Attachment>().map(JSONObject: JSON["attachment"])
                        success(attachment!)
                    }
                })
            case .failure(let error):
                // TODO - handle error case
                print(error)
            }
            
        })
    }
}
