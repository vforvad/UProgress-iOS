//
//  DirectionViewActions.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 10.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol DirectionViewActionsProtocol {
    func selectStepItem(step: Step)
    func createStep()
    func showStepDescription(step: Step)
}
