//
//  DeviceToken.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 26.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import KeychainSwift

class DeviceToken {
    let token_key = "DEVICE_ID"
    var keychain = KeychainSwift()
    var token: String!
    
    class var sharedInstance: DeviceToken {
        struct Singleton {
            static let instance: DeviceToken = DeviceToken()
        }
        return Singleton.instance
    }
    
    func setToken(token: String!) {
        self.token = token
        keychain.set(token, forKey: token_key)
    }
    
    func getToken() -> String! {
        if self.token != nil {
            return self.token
        }
        else {
            return keychain.get(token_key)!
        }
    }

}
