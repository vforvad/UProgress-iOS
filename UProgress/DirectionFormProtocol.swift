//
//  DirectionFormProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 27.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol DirectionFormProtocol {
    func successCreation(direction: Direction)
    func failedCreation(error: ServerError)
    func startLoader()
    func stopLoader()
}
