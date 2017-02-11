//
//  StepPresenterProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 11.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol StepPresenterProtocol {
    func createStep(userId: String!, directionId: String!, parameters: Dictionary<String, AnyObject>)
}
