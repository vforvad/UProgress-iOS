//
//  DirectionsDetailProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol DirectionsDetailViewProtocol {
    func startLoader()
    func stopLoader()
    func startRefreshing()
    func stopRefreshing()
    func successDirectionLoad(direction: Direction!)
    func failedDirectionLoad(error: ServerError)
    func successStepUpdate(step: Step!)
    func failureStepUpdate(error: ServerError!)
    func successStepDelete(step: Step!)
    func failureStepDelete(error: ServerError!)
}
