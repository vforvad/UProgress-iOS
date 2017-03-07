//
//  StatisticsManagerSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 07.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class StatisticsManagerSpec: QuickSpec {
    var model = StatisticsManager()
    var statistics: StatisticsInfo!
    var updateError: ServerError!
    
    override func spec() {
        super.spec()
        
        describe("loadStatistics()") {
            context("success load") {
                beforeEach {
                    let path = Bundle(for: type(of: self)).path(forResource: "statistics", ofType: "json")!
                    let data = NSData(contentsOfFile: path)!
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad/statistics"), jsonData(data as Data))
                    
                    waitUntil(action: { done in
                        self.model.loadStatistics(userId: "vforvad",
                        success: { statistics in
                            self.statistics = statistics
                            done()
                        },
                        failure: { error in
                                                    
                        })
                        
                    })
                }
                
                it("receives statistics information") {
                    expect(self.statistics).toEventuallyNot(beNil())
                }
                
                it("has directions key") {
                    expect(self.statistics.directions).toEventuallyNot(beNil())
                }
                
                it("has steps key") {
                    expect(self.statistics.steps).toEventuallyNot(beNil())
                }
                
                it("has directions_steps key") {
                    expect(self.statistics.directionSteps).toEventuallyNot(beNil())
                }
            }
            
            context("failed informaton") {
                // TODO implement specs for this type 
            }
        }
    }
}
