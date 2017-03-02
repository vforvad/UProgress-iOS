//
//  StatisticsManager.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 28.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol StatisticsManagerProtocol {
    func loadStatistics(userId: String, success: @escaping (_ statistics: StatisticsInfo) -> Void, failure: @escaping (_ error: ServerError) -> Void)
}
