//
//  AuthorizationManager.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire

class AuthorizationManager: AuthorizationManagerProtocol {
    init() {
    }
    
    internal func signUp(signUpParameters: Dictionary<String, AnyObject>, success: @escaping (String) -> Void, failure: @escaping (NSError) -> Void) {
    
    
    }
    
    internal func signIn(signInParameters: Dictionary<String, AnyObject>, success: @escaping (String) -> Void, failure: @escaping (NSError) -> Void) {
        ApiRequest.sharedInstance.post(url: "/sessions", parameters: ["user": signInParameters] as NSDictionary).responseJSON { response in
            switch(response.result) {
            case .success(let value):
                let dictionary = value as! Dictionary<String, String>
                success(dictionary["token"]!)
            case .failure(let errorValue):
                failure(errorValue as NSError)
            }
        }
    }
}
