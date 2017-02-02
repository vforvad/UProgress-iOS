//
//  ErrorsHandling.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 02.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol ErrorsHandling {
    func handleErrors(errors: ServerError)
}
