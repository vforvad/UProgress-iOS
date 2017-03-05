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
                    it("receives failed callback") {
                        expect(model.loadDirection).to(beFalsy())
                    }
                }
                
                context("view") {
                    it("receives failed callback") {
                        expect(self.view.directionLoad).to(beFalsy())
                    }
                }

            }
        }
        
        describe("updateStep()") {
            context("with valid attributes") {
                let model = DirectionDetailManagerMock(request: true)
                beforeEach {
                    let presenter = DirectionsDetailPresenter(model: model, view: self.view)
                    presenter.updateStep(userId: "vforvad", directionId: "1", stepId: "1", parameters: ["title": "title" as AnyObject])
                }
                
                context("model") {
                    it("receives success callback") {
                        expect(model.updateStep).to(beTruthy())
                    }
                }
                
                context("view") {
                    it("receives success callback") {
                        expect(self.view.stepUpdate).to(beTruthy())
                    }
                }
            }
            
            context("with invalid attributes") {
                let model = DirectionDetailManagerMock(request: false)
                beforeEach {
                    let presenter = DirectionsDetailPresenter(model: model, view: self.view)
                    presenter.updateStep(userId: "vforvad", directionId: "1", stepId: "1", parameters: ["title": "" as AnyObject])
                }
                
                context("model") {
                    it("receives failed callback") {
                        expect(model.updateStep).to(beFalsy())
                    }
                }
                
                context("view") {
                    it("receives failed callback") {
                        expect(self.view.stepUpdate).to(beFalsy())
                    }
                }
            }
        }
        
        describe("deleteStep()") {
            context("success") {
                let model = DirectionDetailManagerMock(request: true)
                beforeEach {
                    let presenter = DirectionsDetailPresenter(model: model, view: self.view)
                    presenter.deleteStep(userId: "vforvad", directionId: "1", stepId: "1")
                }
                context("model") {
                    it("receives success callback") {
                        expect(model.deleteStep).to(beTruthy())
                    }
                }
                
                context("view") {
                    it("receives success callback") {
                        expect(self.view.stepDelete).to(beTruthy())
                    }
                }
            }
            
            context("failure") {
                let model = DirectionDetailManagerMock(request: false)
                beforeEach {
                    let presenter = DirectionsDetailPresenter(model: model, view: self.view)
                    presenter.deleteStep(userId: "vforvad", directionId: "1", stepId: "1")
                }
                
                context("model") {
                    it("receives success callback") {
                        expect(model.deleteStep).to(beFalsy())
                    }
                }
                
                context("view") {
                    it("receives success callback") {
                        expect(self.view.stepDelete).to(beFalsy())
                    }
                }
            }
        }
    }
}
