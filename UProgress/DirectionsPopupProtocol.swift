//
//  ViewControllerPopupProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 10.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol DirectionsPopupProtocol {
    func successOperation(step: Step)
    func failedOperation(error: ServerError)
}
