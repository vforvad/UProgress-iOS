//
//  SignInProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

protocol SignInProtocol {
    func scrollToField(view: UIView)
    func signInRequest(parameters: Dictionary<String, AnyObject>)
    func signUpRequest(parameters: Dictionary<String, AnyObject>)
    func restorePasswordRequest(parameters: Dictionary<String, AnyObject>)
}
