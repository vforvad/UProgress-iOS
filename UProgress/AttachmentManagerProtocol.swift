//
//  AttachmentManagerProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 27.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

protocol AttachmentManagerProtocol {
    func uploadImage(image: UIImage!, attachableId: Int!, attachableType: String!, success: @escaping (_ attachment: Attachment) -> Void, failure: @escaping (_ error: ServerError) -> Void)
}
