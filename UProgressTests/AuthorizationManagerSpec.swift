//
//  AuthorizationManagerSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 05.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class AuthorizationManagerSpec: QuickSpec {
    let model = AuthorizationManager()
    var currentUser: User!
    var errors: ServerError!
    
    override func spec() {
        super.spec()
        
        beforeEach {
            let path = Bundle(for: type(of: self)).path(forResource: "current_user", ofType: "json")!
            let data = NSData(contentsOfFile: path)!
            MockingjayProtocol.addStub(matcher: uri("\(ApiRequest.sharedInstance.host)/api/v1/sessions/current"), builder: jsonData(data as Data))
            
            let imagePath = Bundle(for: type(of: self)).path(forResource: "shut_up_and_take_my_money", ofType: "jpg")!
            let imageData = NSData(contentsOfFile: imagePath)!
            self.stub(uri("http:1234/image.jpg"), jsonData(imageData as Data))
        }
        
        describe("signIn()") {
            
            context("with valid attributes") {
                beforeEach {
                    let path = Bundle(for: type(of: self)).path(forResource: "token", ofType: "json")!
                    let data = NSData(contentsOfFile: path)!
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/sessions"), jsonData(data as Data))
                    
                        self.model.signIn(signInParameters: ["email": "111@mail.ru" as AnyObject],
                        success: { user in
                            self.currentUser = user
                        },
                        failure: { error in
                        
                        })
                    
                }
                
                it("user exists") {
                    expect(self.currentUser).toEventuallyNot(beNil(), timeout: 1.0)
                }

            }
            
            context("with invalid attributes") {
                beforeEach {
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/sessions"), json(["errors": ["email": "Can't be blank"]], status: 403, headers: [:]))
                    self.model.signIn(signInParameters: ["email": "111@mail.ru" as AnyObject],
                    success: { user in
                        self.currentUser = user
                    },
                    failure: { error in
                        self.errors = error
                    })
                }
                
                it("receive error") {
                    expect(self.errors).toEventuallyNot(beNil(), timeout: 1.0)
                }
            }
        }
        
        describe("signUp()") {
            context("with valid attributes") {
                beforeEach {
                    let path = Bundle(for: type(of: self)).path(forResource: "token", ofType: "json")!
                    let data = NSData(contentsOfFile: path)!
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/registrations"), jsonData(data as Data))
                    
                    self.model.signIn(signInParameters: ["email": "111@mail.ru" as AnyObject],
                    success: { user in
                        self.currentUser = user
                    },
                    failure: { error in
                                        
                    })
                    
                }
                
                it("receives current user") {
                    expect(self.currentUser).toEventuallyNot(beNil(), timeout: 1.0)
                }
            }
            
            context("with invalid attributes") {
                beforeEach {
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/registrations"), json(["errors": ["email": "Can't be blank"]], status: 403, headers: [:]))
                    self.model.signIn(signInParameters: ["email": "" as AnyObject],
                                      success: { user in
                                        self.currentUser = user
                    },
                                      failure: { error in
                                        self.errors = error
                    })
                }
                
                it("receive error") {
                    expect(self.errors).toEventuallyNot(beNil(), timeout: 1.0)
                }
            }
        }
        
        describe("currentUser()") {
            beforeEach {
                self.model.currentUser(
                success: { user in
                    self.currentUser = user
                },
                failure: { error in
                
                })
            }
            it("receives current user") {
                expect(self.currentUser).toEventuallyNot(beNil(), timeout: 1.0)
            }
        }
        
        describe("restorePassword()") {
            var tokenValue: String!
            
            context("with valid attributes") {
                self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/sessions/restore_password"), json(["token": "12345"], status: 200, headers: [:]))
                self.model.restorePassword(restorePassword: ["email": "vforvad@gmail.com" as AnyObject],
                                  success: { token in
                                    tokenValue = token
                },
                                  failure: { error in
                                    self.errors = error
                })
                
                it("receives token") {
                    expect(tokenValue).toEventuallyNot(beNil(), timeout: 1.0)
                }
            }
            
            context("with invalid attributes") {
                context("with valid attributes") {
                    beforeEach {
                        self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/sessions/restore_password"), json(["errors": ["email": "Can't be blank"]], status: 422, headers: [:]))
                        self.model.restorePassword(restorePassword: ["email": "" as AnyObject],
                                                   success: { token in
                        },
                                                   failure: { error in
                                                    self.errors = error
                        })
                    }
                    
                    it("receives errors") {
                        expect(self.errors).toEventuallyNot(beNil(), timeout: 1.0)
                    }
                }
            }
        }
    }
}
