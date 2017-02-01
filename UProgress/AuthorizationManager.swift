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
        var params = signInParameters
        params.updateValue(self.deviseInormation(provider: "UProgress"), forKey: "authorization")
        ApiRequest.sharedInstance.post(url: "/sessions", parameters: ["user": params] as NSDictionary).responseJSON { response in
            switch(response.result) {
            case .success(let value):
                let dictionary = value as! Dictionary<String, AnyObject>
                success(dictionary["token"]! as! String)
            case .failure(let errorValue):
                failure(errorValue as NSError)
            }
        }
    }
    
    func deviseInormation(provider: String!) -> NSDictionary {
        let devise = UIDevice.current
        let deviseData = ["platform": devise.systemName, "platform_version": devise.systemVersion,
                          "app_name": devise.name, provider: provider]
        return deviseData as NSDictionary
    }
}
