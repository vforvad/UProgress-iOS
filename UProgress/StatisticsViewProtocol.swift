//
//  StatisticsViewProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 28.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol StatisticsViewProtocol {
    func successStatisticsLoad(statistics: StatisticsInfo!)
    func failedStatisticsLoad(error: ServerError!)
    func startLoader()
    func stopLoader()
}
