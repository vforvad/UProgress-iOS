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
            context("with valid attributes") {
                it("creates new step") {
                
                }
            }
            
            context("with invalid atrributes") {
            }
        }
        
        describe("updateStep()") {
            
        }
        
        describe("deleteStep()") {
            
        }
    }
}
