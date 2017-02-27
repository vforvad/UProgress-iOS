//
//  DirectionPopupActions.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 27.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol DirectionPopupActions {
    func successOperation(direction: Direction)
    func failedOperation(error: ServerError)
}
