//
//  AuthorizationManagerMock.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 05.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class AuthorizationManagerMock: AuthorizationManagerProtocol {
    var successRequest: Bool!
    var signIn: Bool!
    var signUp: Bool!
    var userReceived: Bool!
    
    init(request: Bool) {
        self.successRequest = request
    }

    func signIn(signInParameters: Dictionary<String, AnyObject>, success: @escaping (_ currentUser: User) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        if successRequest! {
            signIn = true
            success(User())
        }
        else {
            signIn = false
            failure(ServerError())
        }
    }
    
    func signUp(signUpParameters: Dictionary<String, AnyObject>, success: @escaping (_ currentUser: User) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        if successRequest! {
            signUp = true
            success(User())
        }
        else {
            signUp = false
            failure(ServerError())
        }
    }
    
    func currentUser(success: @escaping (User) -> Void, failure: @escaping (ServerError) -> Void) {
        if successRequest! {
            userReceived = true
            success(User())
        }
        else {
            userReceived = false
            failure(ServerError())
        }
    }
}
