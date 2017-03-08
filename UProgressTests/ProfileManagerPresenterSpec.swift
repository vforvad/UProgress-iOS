//
//  ProfileManagerPresenterSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 07.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class ProfileManagerPresenterSpec: QuickSpec {
    let view = ProfileManagerViewMock()
    class ProfileManagerViewMock: ProfileViewProtocol {
        var successUpdate: Bool!
        
        func successUpdate(user: User!) { successUpdate = true }
        func failedUpdate(error: ServerError!) { successUpdate = false }
        func startLoader() {  }
        func stopLoader() {  }
    }
    override func spec() {
        super.spec()
        
        describe("updateProfile()") {
            context("success operation") {
                let model = ProfileManagerMock(request: true)
                
                beforeEach {
                    let presenter = ProfilePresenter(model: model, view: self.view)
                    presenter.updateProfile(userId: "1", parameters: ["email": "example@mail.com" as AnyObject])
                }
                
                context("model") {
                    it("receives success callback") {
                        expect(model.updateProfile).to(beTruthy())
                    }
                }
                
                context("view") {
                    it("receives success callback") {
                        expect(self.view.successUpdate).to(beTruthy())
                    }
                }
            }
            
            context("failed operation") {
                let model = ProfileManagerMock(request: false)
                
                beforeEach {
                    let presenter = ProfilePresenter(model: model, view: self.view)
                    presenter.updateProfile(userId: "1", parameters: ["email": "" as AnyObject])
                }
                
                context("model") {
                    it("receives failure callback") {
                        expect(model.updateProfile).to(beFalsy())
                    }
                }
                
                context("view") {
                    it("receives failure callback") {
                        expect(self.view.successUpdate).to(beFalsy())
                    }
                }
            }
        }
    }
}
