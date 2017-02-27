//
//  ProfileManagerProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 23.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol ProfileManagerProtocol {
    func updateProfile(userId: String!, profileParameters: Dictionary<String, AnyObject>, success: @escaping (_ currentUser: User) -> Void, failure: @escaping (_ error: ServerError) -> Void)
}
