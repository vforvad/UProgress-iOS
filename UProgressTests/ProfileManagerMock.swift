//
//  ProfileManagerMock.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 07.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class ProfileManagerMock: ProfileManagerProtocol {
    var request: Bool!
    var updateProfile: Bool!
    
    init(request: Bool!) {
        self.request = request
    }
    
    internal func updateProfile(userId: String!, profileParameters: Dictionary<String, AnyObject>, success: @escaping (_ currentUser: User) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        if request! {
            updateProfile = true
            success(User()!)
        }
        else {
            updateProfile = false
            failure(ServerError())
        }
    }
}
