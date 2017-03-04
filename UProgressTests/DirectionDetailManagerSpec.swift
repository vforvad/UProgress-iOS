//
//  DirectionDetailManagerSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 03.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class DirectionDetailManagerSpec: QuickSpec {
    let model = DirectionDetailManager()
    var detailDirection: Direction!
    var createStepError: ServerError!
    
    override func spec() {
        super.spec()
        
        describe("loadDirection()") {
            beforeEach {
                let path = Bundle(for: type(of: self)).path(forResource: "detail_direction", ofType: "json")!
                let data = NSData(contentsOfFile: path)!
                self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad/directions/1"), jsonData(data as Data))
            }
            
            context("successfull load") {
                beforeEach {
                    waitUntil(action: { done in
                        self.model.loadDirection(userNick: "vforvad", directionId: "1",
                            success: { direction in
                                self.detailDirection = direction
                                done()
                        },
                            failure: { error in
                                                    
                        })
                        
                    })
                }
                
                it("direction") {
                   expect(self.detailDirection).toEventuallyNot(beNil())
                }
                
                it("direction have particular id") {
                    expect(self.detailDirection.id).to(equal(1))
                }
            }
        }
        
        describe("createStep()") {
            var createdStep: Step!
            
            context("with valid attributes") {
                beforeEach {
                    let path = Bundle(for: type(of: self)).path(forResource: "new_step", ofType: "json")!
                    let data = NSData(contentsOfFile: path)!
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad/directions/1/steps"), jsonData(data as Data))
                    let params = ["title": "Title", "description": "Description"]
                    
                    waitUntil(action: { done in
                        self.model.createStep(userNick: "vforvad", directionId: "1", parameters: params as Dictionary<String, AnyObject>,
                            success: { step in
                                createdStep = step
                                done()
                        },
                            failure: { error in
                                                    
                        })
                        
                    })
                }
                
                it("creates new step") {
                    expect(createdStep).toEventuallyNot(beNil())
                }
            }
            
            context("with invalid atrributes") {
                beforeEach {
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad/directions/1/steps"), json(["errors": ["title": "Can't be blank"]], status: 403, headers: [:]))
                    let params = ["title": "Title", "description": "Description"]
                    
                    waitUntil(action: { done in
                        self.model.createStep(userNick: "vforvad", directionId: "1", parameters: params as Dictionary<String, AnyObject>,
                            success: { step in
                                                
                        },
                            failure: { error in
                            self.createStepError = error
                            done()
                                                
                        })
                        
                    })
                }
                
                it("does not create a new step") {
                    expect(self.createStepError).toEventuallyNot(beNil())
                }
                
                it("have a particular error key") {
                    expect(self.createStepError.params?["title"]).toEventuallyNot(beNil())
                }
            }
        }
        
        describe("updateStep()") {
            var updatedStep: Step!
            
            context("with valid attributes") {
                beforeEach {
                    let path = Bundle(for: type(of: self)).path(forResource: "new_step", ofType: "json")!
                    let data = NSData(contentsOfFile: path)!
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad/directions/1/steps/1"), jsonData(data as Data))
                    let params = ["title": "step 3", "description": "Description"]
                    
                    waitUntil(action: { done in
                        self.model.updateStep(userNick: "vforvad", directionId: "1", stepId: "1", parameters: params as Dictionary<String, AnyObject>,
                                              success: { step in
                                                updatedStep = step
                                                done()
                        },
                                              failure: { error in
                                                
                        })
                        
                    })
                }
                
                it("return updated step") {
                    expect(updatedStep).toEventuallyNot(beNil())
                }
                
                it("has attributes of the new step") {
                    expect(updatedStep.title).to(equal("step 3"))
                }
            }
            
            context("with invalid attributes") {
                var updateStepError: ServerError!
                
                beforeEach {
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad/directions/1/steps/1"), json(["errors": ["title": "Can't be blank"]], status: 403, headers: [:]))
                    let params = ["title": "Title", "description": "Description"]
                    
                    waitUntil(action: { done in
                        self.model.updateStep(userNick: "vforvad", directionId: "1", stepId: "1", parameters: params as Dictionary<String, AnyObject>,
                                              success: { step in
                                                
                        },
                                              failure: { error in
                                                updateStepError = error
                                                done()
                                                
                        })
                        
                    })
                }
                
                it("receved errors dictionary") {
                    expect(updateStepError).toEventuallyNot(beNil())
                }
                
                it("key for title error is present") {
                    expect(updateStepError.params!["title"]).toEventuallyNot(beNil())
                }
            }
        }
        
        describe("deleteStep()") {
            
        }
    }
}
