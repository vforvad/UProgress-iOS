//
//  AuthorizationPresenterProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol AuthorizationPresenterProtocol {
    func signIn(parameters: Dictionary<String, AnyObject>)
    func signUp(parameters: Dictionary<String, AnyObject>)
    func restorePassword(parameters: Dictionary<String, AnyObject>)
}
