//
//  StepViewProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 11.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol StepViewProtocol {
    func startLoader()
    func stopLoader()
    func successCreation(step: Step!)
    func failureCreation(error: ServerError!)
}
