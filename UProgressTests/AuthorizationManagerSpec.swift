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
            beforeEach {
                let path = Bundle(for: type(of: self)).path(forResource: "token", ofType: "json")!
                let data = NSData(contentsOfFile: path)!
                self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/sessions"), jsonData(data as Data))
            }
            
            context("with valid attributes") {
                beforeEach {
//                    waitUntil(action: { done in
                        self.model.signIn(signInParameters: ["email": "111@mail.ru" as AnyObject],
                        success: { user in
                            self.currentUser = user
                        },
                        failure: { error in
                        
                        })
                        
//                    })
                }
                
                it("user exists") {
                    expect(self.currentUser).toEventuallyNot(beNil(), timeout: 10.0)
                }
                
//                it("direction have particular id") {
//                    expect(self.detailDirection.id).to(equal(1))
//                }
            }
            
            context("with invalid attributes") {
                
            }
        }
        
        describe("signUp()") {
            beforeEach {
                let path = Bundle(for: type(of: self)).path(forResource: "token", ofType: "json")!
                let data = NSData(contentsOfFile: path)!
                self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/registrations"), jsonData(data as Data))
            }
        }
        
        describe("currentUser()") {
        
        }
    }
}
