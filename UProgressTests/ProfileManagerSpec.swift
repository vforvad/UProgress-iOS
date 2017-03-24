//
//  ProfileManagerSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 07.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class ProfileManagerSpec: BaseTest {
    let model = ProfileManager()
    var updatedUser: User!
    var updateError: ServerError!
    
    override func spec() {
        super.spec()
        
        describe("updateProfile()") {
            context("with valid attributes") {
                beforeEach {
                    let path = Bundle(for: type(of: self)).path(forResource: "current_user", ofType: "json")!
                    let data = NSData(contentsOfFile: path)!
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad"), jsonData(data as Data))
                    
                    let params = ["email": "example@mail.com", "nick": "vforvad"]
                    
                    
                    waitUntil(action: { done in
                        self.model.updateProfile(userId: "vforvad", profileParameters: params as Dictionary<String, AnyObject>,
                                              success: { user in
                                                self.updatedUser = user
                                                done()
                        },
                                              failure: { error in
                                                
                        })
                        
                    })
                }
                
                it("receive user information") {
                    expect(self.updatedUser).toEventuallyNot(beNil())
                }
                
                it("update with correct parameters") {
                    expect(self.updatedUser.email).toEventually(equal("example@mail.com"))
                }
            }
            
            context("with invalid attributes") {
                beforeEach {
                    let path = Bundle(for: type(of: self)).path(forResource: "current_user", ofType: "json")!
                    let data = NSData(contentsOfFile: path)!
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad"), json(["errors": ["email": "Can't be blank"]], status: 403, headers: [:]))
                    
                    let params = ["email": "", "nick": "vforvad"]
                    
                    
                    waitUntil(action: { done in
                        self.model.updateProfile(userId: "vforvad", profileParameters: params as Dictionary<String, AnyObject>,
                                                 success: { user in
                                                    
                                                    
                        },
                                                 failure: { error in
                                                    self.updateError = error
                                                    done()
                        })
                        
                    })
                }
                
                it("receives error") {
                    expect(self.updateError).toEventuallyNot(beNil())
                }
                
                it("errors object is not empty") {
                    expect(self.updateError.params?["errors"]?["email"]).toEventuallyNot(beNil())
                }
            }
        }
    }
}
