//
//  SignInProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol SignInProtocol {
    func signInRequest(parameters: Dictionary<String, AnyObject>)
}
