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
import ObjectMapper

class AuthorizationManager: AuthorizationManagerProtocol {
    var keychain = KeychainSwift()
    
    init() {
    }
    
    internal func signUp(signUpParameters: Dictionary<String, AnyObject>, success: @escaping (_ currentUser: User) -> Void, failure: @escaping (ServerError) -> Void) {
        var params = signUpParameters
        params.updateValue(self.deviseInormation(provider: "UProgress"), forKey: "authorization")
        ApiRequest.sharedInstance.post(url: "/registrations", parameters: ["user": params] as NSDictionary).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                let dictionary = response.result.value as! Dictionary<String, AnyObject>
                self.writeToken(token: dictionary["token"]! as! String)
                self.currentUser(success: success, failure: failure)
            }
            else {
                let error = response.result.value as? Dictionary<String, AnyObject>
                failure(ServerError(status: response.response!.statusCode, parameters: error))
            }
        }

    }
    
    internal func signIn(signInParameters: Dictionary<String, AnyObject>, success: @escaping (User) -> Void, failure: @escaping (ServerError) -> Void) {
        var params = signInParameters
        params.updateValue(self.deviseInormation(provider: "UProgress"), forKey: "authorization")
        ApiRequest.sharedInstance.post(url: "/sessions", parameters: ["user": params] as NSDictionary).responseJSON { response in
            if response.response?.statusCode == 200 {
                let dictionary = response.result.value as! Dictionary<String, String>
                self.writeToken(token: dictionary["token"]!)
                self.currentUser(success: success, failure: failure)
            }
            else {
                let error = response.result.value as? Dictionary<String, AnyObject>
                failure(ServerError(status: response.response!.statusCode, parameters: error))
            }
        }
    }
    
    func currentUser(success: @escaping (User) -> Void, failure: @escaping (ServerError) -> Void) {
        ApiRequest.sharedInstance.get(url: "/sessions/current", parameters: [:]).responseJSON { response in
            if response.response?.statusCode == 200 {
                let userObject = response.result.value! as! Dictionary<String, Any>
                let user = Mapper<User>().map(JSONObject: userObject["current_user"])
                AuthorizationService.sharedInstance.currentUser = user
                let notificationName = Notification.Name("signedIn")
                NotificationCenter.default.post(name: notificationName, object: user)
                success(user!)
            } else {
//                let authErrors = response.result.value! as! Dictionary<String, Any>
                failure(ServerError(status: response.response?.statusCode, description: "Token expired"))
            }
        }
    }
    
    private func writeToken(token: String!) {
        self.keychain.set(token, forKey: "uprogresstoken")
    }
    
    func deviseInormation(provider: String!) -> NSDictionary {
        let devise = UIDevice.current
        let app_version = Bundle.main.infoDictionary!["CFBundleShortVersionString"]
        let deviseData = ["platform": devise.systemName, "platform_version": devise.systemVersion,
                          "app_name": "UProgress", provider: provider,
                          "app_version": app_version,
                          "device_token": DeviceToken.sharedInstance.getToken()]
        return deviseData as NSDictionary
    }
}
