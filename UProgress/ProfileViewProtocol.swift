//
//  ProfileViewProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 23.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation


protocol ProfileViewProtocol {
    func successUpdate(user: User!)
    func failedUpdate(error: ServerError!)
    func startLoader()
    func stopLoader()
}
