//
//  StatisticsManagerMock.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 07.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class StatisticsManagerMock: StatisticsManagerProtocol {
    var request: Bool!
    var statisticsLoad: Bool!
    
    init(request: Bool!) {
        self.request = request
    }
    
    internal func loadStatistics(userId: String, success: @escaping (_ statistics: StatisticsInfo) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        if request! {
            self.statisticsLoad = true
            success(StatisticsInfo()!)
        }
        else {
            self.statisticsLoad = false
            failure(ServerError())
        }
    }
}
