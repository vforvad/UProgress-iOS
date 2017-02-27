//
//  ProfilePresenterProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 23.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol ProfilePresenterProtocol {
    func updateProfile(userId: String!, parameters: Dictionary<String, AnyObject>)
}
