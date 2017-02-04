//
//  AuthorizationService.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 02.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import KeychainSwift

class AuthorizationService {
    var currentUser: User!
    var keychain = KeychainSwift()
    
    class var sharedInstance: AuthorizationService {
        struct Singleton {
            static let instance: AuthorizationService = AuthorizationService()
        }
        
        return Singleton.instance
    }
    
    func getToken() -> String {
        return self.keychain.get("uprogresstoken")!
    }
}
