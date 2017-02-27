//
//  AttachmentPresenter.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 27.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import  UIKit

class AttachmentPresenter: AttachmentPresenterProtocol {
    private var view: AttachmentViewProtocol!
    private var model: AttachmentManagerProtocol!
    
    init(model: AttachmentManagerProtocol, view: AttachmentViewProtocol) {
        self.model = model
        self.view = view
    }
    
    internal func uploadProfileImage(image: UIImage!, attachableId: Int!, attachableType: String!) {
        self.view.startLoader()
        model.uploadImage(image: image, attachableId: attachableId, attachableType: attachableType,
        success: { attachment in
            self.view.stopLoader()
            self.view.successAttachmentUpload(attachment: attachment)
        },
        failure: { error in
            self.view.stopLoader()
            self.view.failedAttachmentUpload(error: error)
        })
    }
}
