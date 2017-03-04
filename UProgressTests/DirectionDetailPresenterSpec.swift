//
//  DirectionDetailPresenterSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 04.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class DirectionDetailPresenterSpec: QuickSpec {
    let view = DirectionDetailViewMock()
    
    class DirectionDetailViewMock: DirectionsDetailViewProtocol {
        var directionLoad: Bool!
        var stepUpdate: Bool!
        var stepCreate: Bool!
        var stepDelete: Bool!
        internal func startLoader() {}
        internal func stopLoader() {}
        internal func successDirectionLoad(direction: Direction!) { directionLoad = true }
        internal func failedDirectionLoad(error: NSError) { directionLoad = false }
        internal func successStepUpdate(step: Step!) { stepUpdate = true }
        internal func failureStepUpdate(error: ServerError!) { stepUpdate = false }
        internal func successStepDelete(step: Step!) { stepDelete = true }
        internal func failureStepDelete(error: ServerError!) { stepDelete = false }
    }
    
    override func spec() {
        super.spec()
        
        describe("loadDirection()") {
            context("success operation") {
                let model = DirectionDetailManagerMock(request: true)
                beforeEach {
                    let presenter = DirectionsDetailPresenter(model: model, view: self.view)
                    presenter.loadDirection(userNick: "vforvad", directionId: "1")
                }
                
                context("model") {
                    it("receives success callback") {
                        expect(model.loadDirection).to(beTruthy())
                    }
                }
                
                context("view") {
                    it("receives success callback") {
                        expect(self.view.directionLoad).to(beTruthy())
                    }
                }
                
            }
            
            context("failure operation") {
                let model = DirectionDetailManagerMock(request: false)
                beforeEach {
                    let presenter = DirectionsDetailPresenter(model: model, view: self.view)
                    presenter.loadDirection(userNick: "vforvad", directionId: "1")
                }
                
                context("model") {
                    it("receives success callback") {
                        expect(model.loadDirection).to(beFalsy())
                    }
                }
                
                context("view") {
                    it("receives success callback") {
                        expect(self.view.directionLoad).to(beFalsy())
                    }
                }

            }
        }
        
        describe("updateStep()") {
            
        }
        
        describe("deleteStep()") {
            
        }
    }
}
