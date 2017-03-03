//
//  DirectionsFormPresenterSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 03.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class DirectionsFormPresenterSpec: QuickSpec {
    
    class DirectionsFormViewMock: DirectionFormProtocol {
        var successCalled: Bool!
        
        func successCreation(direction: Direction) {
            successCalled = true
        }
        
        func failedCreation(error: ServerError) {
            successCalled = false
        }
        
        func startLoader() {
            
        }
        
        func stopLoader() {
            
        }
    }
    
    override func spec() {
        super.spec()
        
        describe("createDirection()") {
            context("with valid attributes") {
                it("creates new direction") {
                    let model = DirectionsManagerMock(request: true)
                    let view = DirectionsFormViewMock()
                    let presenter = DirectionFormPresenter(model: model, view: view)
                    presenter.createDirection(userNick: "vforvad", parameters:
                        ["direction": ["title": "Title", "description": "Description"]]
                    )
                    expect(view.successCalled).to(beTruthy())
                }
            }
            
            context("with invalid attributes") {
                it("does not create new direction") {
                    let model = DirectionsManagerMock(request: false)
                    let view = DirectionsFormViewMock()
                    let presenter = DirectionFormPresenter(model: model, view: view)
                    presenter.createDirection(userNick: "vforvad", parameters:
                        ["direction": ["title": "Title", "description": ""]]
                    )
                    expect(view.successCalled).to(beFalsy())
                }
            }
        }
    }
}

