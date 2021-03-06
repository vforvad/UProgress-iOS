//
//  AuthorizationManagerProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol AuthorizationManagerProtocol {
    func signIn(signInParameters: Dictionary<String, AnyObject>, success: @escaping (_ currentUser: User) -> Void, failure: @escaping (_ error: ServerError) -> Void)
    
    func signUp(signUpParameters: Dictionary<String, AnyObject>, success: @escaping (_ currentUser: User) -> Void, failure: @escaping (_ error: ServerError) -> Void)
    
    func restorePassword(restorePassword: Dictionary<String, AnyObject>, success: @escaping (_ token: String) -> Void, failure: @escaping (_ error: ServerError) -> Void)
    
    func resetPassword(resetPasswordParams: Dictionary<String, AnyObject>, success: @escaping (_ message: String) -> Void, failure: @escaping (_ error: ServerError) -> Void)
    
    func currentUser(success: @escaping (User) -> Void, failure: @escaping (ServerError) -> Void)
}
