//
//  StatisticsPresenter.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 28.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class StatisticsPresenter: StatisticsPresenterProtocol {
    private var model: StatisticsManagerProtocol!
    private var view: StatisticsViewProtocol!
    
    init(model: StatisticsManagerProtocol!, view: StatisticsViewProtocol) {
        self.model = model
        self.view = view
    }
    
    internal func loadStatistics(userId: String!) {
        view.startLoader()
        model.loadStatistics(userId: userId,
        success: { statistics in
            self.view.stopLoader()
            self.view.successStatisticsLoad(statistics: statistics)
        },
        failure: { error in
            self.view.stopLoader()
            self.view.failedStatisticsLoad(error: error)
        })
    }
}
