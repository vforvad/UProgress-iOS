//
//  AuthorizationManager.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire
import KeychainSwift

class AuthorizationManager: AuthorizationManagerProtocol {
    var keychain = KeychainSwift()
    
    init() {
    }
    
    internal func signUp(signUpParameters: Dictionary<String, AnyObject>, success: @escaping (String) -> Void, failure: @escaping (NSError) -> Void) {
    
    
    }
    
    internal func signIn(signInParameters: Dictionary<String, AnyObject>, success: @escaping (User) -> Void, failure: @escaping (NSError) -> Void) {
        var params = signInParameters
        params.updateValue(self.deviseInormation(provider: "UProgress"), forKey: "authorization")
        ApiRequest.sharedInstance.post(url: "/sessions", parameters: ["user": params] as NSDictionary).responseJSON { response in
            switch(response.result) {
            case .success(let value):
                let dictionary = value as! Dictionary<String, AnyObject>
                self.writeToken(token: dictionary["token"]! as! String)
                self.currentUser(success: success, failure: failure)
            case .failure(let errorValue):
                failure(errorValue as NSError)
            }
        }
    }
    
    private func currentUser(success: @escaping (User) -> Void, failure: @escaping (NSError) -> Void) {
        ApiRequest.sharedInstance.get(url: "/sessions/current", parameters: [:]).responseObject(keyPath: "current_user") { (response: DataResponse<User>) in
            switch(response.result) {
            case .success(let value):
                success(value)
            case .failure(let errorValue):
                failure(errorValue as NSError)
            }
        }
    }
    
    private func writeToken(token: String!) {
        self.keychain.set(token, forKey: "uprogresstoken")
    }
    
    func deviseInormation(provider: String!) -> NSDictionary {
        let devise = UIDevice.current
        let deviseData = ["platform": devise.systemName, "platform_version": devise.systemVersion,
                          "app_name": devise.name, provider: provider]
        return deviseData as NSDictionary
    }
}
