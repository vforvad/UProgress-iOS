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

class DirectionManagerSpec: QuickSpec {
    override func spec() {
        super.spec()
        var directionsList: [Direction]!
        
        describe("first test") {
            it("should pass") {
                let path = Bundle(for: type(of: self)).path(forResource: "directions", ofType: "json")!
                let data = NSData(contentsOfFile: path)!
                self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad/directions?page=1"), jsonData(data as Data))
                let model = DirectionManager()
                
                waitUntil(action: { done in
                    model.loadDirectionsList(userNick: "vforvad", pageNumber: 1,
                                             success: { directions in
                                                directionsList = directions
                                                done()
                    },
                                             failure: { error in
                                                
                    })
                    
                })
                
                expect(directionsList).toEventuallyNot(beNil())
            }
        }
    }
}
