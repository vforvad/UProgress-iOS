//
//  StatisticsPresenterSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 07.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class StatisticsPresenterSpec: QuickSpec {
    let view = StatisticsViewMock()
    
    class StatisticsViewMock: StatisticsViewProtocol {
        var statisticsLoad: Bool!
        
        internal func successStatisticsLoad(statistics: StatisticsInfo!) { statisticsLoad = true }
        internal func failedStatisticsLoad(error: ServerError!) { statisticsLoad = false }
        internal func startLoader() {}
        internal func stopLoader() {}
    }
    
    override func spec() {
        super.spec()
        
        describe("loadStatistics()") {
            context("success") {
                let model = StatisticsManagerMock(request: true)
                
                beforeEach {
                    let presenter = StatisticsPresenter(model: model, view: self.view)
                    presenter.loadStatistics(userId: "1")
                }
                
                context("model") {
                    it("receives success callback") {
                        expect(model.statisticsLoad).to(beTruthy())
                    }
                }
                
                context("view") {
                    it("receives success callback") {
                        expect(self.view.statisticsLoad).to(beTruthy())
                    }
                }
            }
            
            context("failed") {
                let model = StatisticsManagerMock(request: false)
                
                beforeEach {
                    let presenter = StatisticsPresenter(model: model, view: self.view)
                    presenter.loadStatistics(userId: "1")
                }
                
                context("model") {
                    it("receives failure callback") {
                        expect(model.statisticsLoad).to(beFalsy())
                    }
                }
                
                context("view") {
                    it("receives failure callback") {
                        expect(self.view.statisticsLoad).to(beFalsy())
                    }
                }
            }
        }
    }
}
