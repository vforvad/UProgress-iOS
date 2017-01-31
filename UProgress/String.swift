//
//  String.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 31.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

extension String {
    var dateFromISO8601: Date? {
        return Date.iso8601Formatter.date(from: self)
    }
}
