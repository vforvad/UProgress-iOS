//
//  AttachmentViewProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 27.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol AttachmentViewProtocol {
    func successAttachmentUpload(attachment: Attachment)
    func failedAttachmentUpload(error: ServerError)
    func startLoader()
    func stopLoader()
}
