//
//  AttachmentManagerMock.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 08.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class AttachmentManagerMock: AttachmentManagerProtocol {
    var request: Bool!
    var successLoad: Bool!
    
    init(request: Bool!) {
        self.request = request
    }
    func uploadImage(image: UIImage!, attachableId: Int!, attachableType: String!, success: @escaping (_ attachment: Attachment) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        if request! {
            successLoad = true
            success(Attachment()!)
        }
        else {
            successLoad = false
            failure(ServerError())
        }
    }
}
