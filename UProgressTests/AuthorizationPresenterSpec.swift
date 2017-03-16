//
//  AuthorizationPresenterSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class AuthorizationPresenterSpec: QuickSpec {
    
    let view = AuthorizationViewMock()
    
    class AuthorizationViewMock: AuthorizationViewProtocol {
        internal func startLoader() {}
        internal func stopLoader() {}

        var success: Bool!
        var signInFailure: Bool!
        var signUpFailure: Bool!
        
        func successSignIn(currentUser: User) { success = true }
        func failedSignIn(error: ServerError) { signInFailure = true }
        func failedSignUp(error: ServerError) {
            signUpFailure = true
        }
    }
    
    override func spec() {
        super.spec()
        
        describe("signIn()") {
            context("sucecess") {
                let model = AuthorizationManagerMock(request: true)
                
                beforeEach {
                    let presenter = AuthorizationPresenter(model: model, view: self.view)
                    presenter.signIn(parameters: ["email": "example@mail.com" as AnyObject])
                    
                }
                
                context("model") {
                    it("received success callback") {
                        expect(model.signIn).to(beTruthy())
                    }
                }
                
                context("view") {
                    it("received success callback") {
                        expect(self.view.success).to(beTruthy())
                    }
                }
                
            }
            
            context("failure") {
                let model = AuthorizationManagerMock(request: false)
                
                beforeEach {
                    let presenter = AuthorizationPresenter(model: model, view: self.view)
                    presenter.signIn(parameters: ["email": "" as AnyObject])
                    
                }
                
                context("model") {
                    it("received failure callback") {
                        expect(model.signIn).to(beFalsy())
                    }
                }
                
                context("view") {
                    it("received failure callback") {
                        expect(self.view.signInFailure).to(beTruthy())
                    }
                }
            }
        }
        
        describe("signUp()") {
            context("sucecess") {
                let model = AuthorizationManagerMock(request: true)
                
                beforeEach {
                    let presenter = AuthorizationPresenter(model: model, view: self.view)
                    presenter.signUp(parameters: ["email": "example@mail.com" as AnyObject])
                    
                }
                
                context("model") {
                    it("received success callback") {
                        expect(model.signUp).to(beTruthy())
                    }
                }
                
                context("view") {
                    it("received success callback") {
                        expect(self.view.success).to(beTruthy())
                    }
                }
            }
            
            context("failure") {
                let model = AuthorizationManagerMock(request: false)
                
                beforeEach {
                    let presenter = AuthorizationPresenter(model: model, view: self.view)
                    presenter.signUp(parameters: ["email": "" as AnyObject])
                    
                }
                
                context("model") {
                    it("received failure callback") {
                        expect(model.signUp).to(beFalsy())
                    }
                }
                
                context("view") {
                    it("received failure callback") {
                        expect(self.view.signUpFailure).to(beTruthy())
                    }
                }
            }
        }
    }
}
