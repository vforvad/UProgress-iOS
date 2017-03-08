//
//  AttachmentPresenterSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 08.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class AttachmentPresenterSpec: QuickSpec {
    let view = AttachmentViewMock()
    
    class AttachmentViewMock: AttachmentViewProtocol {
        var success: Bool!
        
        internal func successAttachmentUpload(attachment: Attachment) { success = true }
        internal func failedAttachmentUpload(error: ServerError) { success = false }
        internal func startLoader() {}
        internal func stopLoader() {}
    }
    
    override func spec() {
        super.spec()
        
        describe("uploadProfileImage()") {
            context("success") {
                let model = AttachmentManagerMock(request: true)
                
                beforeEach {
                    let presenter = AttachmentPresenter(model: model, view: self.view)
                    presenter.uploadProfileImage(image: UIImage(), attachableId: 0, attachableType: "User")
                }
                
                context("model") {
                    it("receives success callback") {
                        expect(model.successLoad).to(beTruthy())
                    }
                }
                
                context("view") {
                    it("receives success callback") {
                        expect(self.view.success).to(beTruthy())
                    }
                }
            }
            
            context("failure") {
                let model = AttachmentManagerMock(request: false)
                
                beforeEach {
                    let presenter = AttachmentPresenter(model: model, view: self.view)
                    presenter.uploadProfileImage(image: UIImage(), attachableId: 0, attachableType: "User")
                }
                
                context("model") {
                    it("receives failure callback") {
                        expect(model.successLoad).to(beFalsy())
                    }
                }
                
                context("view") {
                    it("receives failure callback") {
                        expect(self.view.success).to(beFalsy())
                    }
                }
            }
        }
    }
}
