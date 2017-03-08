//
//  StepPresenterSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 05.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class StepPresenterSpec: QuickSpec {
    let view = StepViewMock()
    
    class StepViewMock: StepViewProtocol {
        var createdStep: Bool!
        
        func startLoader() {}
        func stopLoader() {}
        func successCreation(step: Step!) { createdStep = true }
        func failureCreation(error: ServerError!) { createdStep = false }
    }
    override func spec() {
        super.spec()
        
        describe("createStep") {
            context("success") {
                let model = DirectionDetailManagerMock(request: true)
                beforeEach {
                    let presenter = StepPresenter(model: model, view: self.view)
                    presenter.createStep(userId: "1", directionId: "1", parameters: ["title": "1" as AnyObject])
                }
                
                context("model") {
                    it("receives success callback") {
                        expect(model.createStep).to(beTruthy())
                    }
                }
                
                context("view") {
                    it("receives success callback") {
                        expect(self.view.createdStep).to(beTruthy())
                    }
                }
            }
            
            context("failure") {
                let model = DirectionDetailManagerMock(request: false)
                beforeEach {
                    let presenter = StepPresenter(model: model, view: self.view)
                    presenter.createStep(userId: "1", directionId: "1", parameters: ["title": "" as AnyObject])
                }
                
                context("model") {
                    it("receives success callback") {
                        expect(model.createStep).to(beFalsy())
                    }
                }
                
                context("view") {
                    it("receives success callback") {
                        expect(self.view.createdStep).to(beFalsy())
                    }
                }
            }
        }
    }
}
