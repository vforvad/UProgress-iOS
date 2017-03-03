//
//  DirectionsManagerSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 03.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay
import Alamofire

class DirectionManagerSpec: QuickSpec {
    override func spec() {
        super.spec()
        var directionsList: [Direction]!
        var createdDirection: Direction!
        let model = DirectionManager()
        
        beforeEach {
            let path = Bundle(for: type(of: self)).path(forResource: "directions", ofType: "json")!
            let data = NSData(contentsOfFile: path)!
            self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad/directions?page=1"), jsonData(data as Data))
        }
        
        describe("loadDirectionsList()") {
            
            beforeEach {
                waitUntil(action: { done in
                    model.loadDirectionsList(userNick: "vforvad", pageNumber: 1,
                        success: { directions in
                            directionsList = directions
                            done()
                    },
                        failure: { error in
                                                
                    })
                    
                })
            }
            
            it("return directions list") {
                expect(directionsList).toEventuallyNot(beNil())
            }
            
            it("contains correct direction") {
                let direction = directionsList.first!
                expect(direction.id).to(equal(318))
            }
        }
        
        describe("createDirection()") {
            beforeEach {
                let path = Bundle(for: type(of: self)).path(forResource: "new_direction", ofType: "json")!
                let data = NSData(contentsOfFile: path)!
                self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad/directions"), jsonData(data as Data))
            }
            
            context("with valid attributes") {
                beforeEach {
                    waitUntil(action: { done in
                        model.createDirection(userNick: "vforvad", parameters: ["direction": ["title": "Title", "description": "Description"]],
                            success: { direction in
                                createdDirection = direction
                                done()
                        },
                            failure: { error in
                                
                        })
                        
                    })
                }
                
                it("creates new direction") {
                    expect(createdDirection).toEventuallyNot(beNil())
                }
                
                it("creates specific direction") {
                    expect(createdDirection.id).to(equal(1))
                }
            }
            
            context("with invalid attributes") {
                var errorObject: ServerError!
                
                beforeEach {
                    
                    let error = NSError(domain: "Unprocessable entity", code: 403, userInfo: ["errors": ["title": "Can't be blank"]])
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad/directions"), json(["errors": ["title": "Can't be blank"]], status: 403, headers: [:]))
                    waitUntil(action: { done in
                        model.createDirection(userNick: "vforvad", parameters: ["direction": ["title": "Title", "description": "Description"]],
                             success: { direction in
                                                
                        },
                            failure: { error in
                                errorObject = error
                                done()
                                                
                        })
                        
                    })
                }
                
                it("does not create new direction") {
                    expect(errorObject).toEventuallyNot(beNil())
                }
                
                it("contain title key") {
                    expect(errorObject.params?["title"]).toEventuallyNot(beNil())
                }
            }
        }
    }
}
