//
//  SignInViewProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol AuthorizationViewProtocol {
    func startLoader()
    func stopLoader()
    func successSignIn(currentUser: User)
    func failedSignIn(error: ServerError)
    func failedSignUp(error: ServerError)
}
