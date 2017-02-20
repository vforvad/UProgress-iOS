//
//  UProgressTests.swift
//  UProgressTests
//
//  Created by Vadim Sokoltsov on 28.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import XCTest

@testable import UProgress

class DirectionsListPresenterTest: XCTestCase {
    
    
    class DirectionsListViewMock: DirectionViewProtocol {
        var successCalled: Bool!
    
        
        internal func successDirectionsLoad(directions: [Direction]!) {
            successCalled  = true
        }
        
        internal func failedDirectionsLoad(error: NSError) {
            successCalled = false
        }
        
        
        internal func startLoader() {}
        internal func stopLoader() {}
        internal func startRefresh() {}
        internal func stopRefresh() {}
        internal func stopInfiniteScroll() {}
        internal func successLoadMoreDirections(directions: [Direction]!) {}

    }
    
    class DirectionsManagerMock: DirectionModelProtocol {
        var successCall: Bool!
        var successRequest = false
        
        init(request: Bool) {
            self.successRequest = request
        }
        
        internal func loadDirectionsList(userNick: String, pageNumber: Int, success: @escaping ([Direction]) -> Void, failure: @escaping (NSError) -> Void) {
            var directions: [Direction]! = [Direction()!]
            if successRequest {
                successCall = true
                success(directions)
            }
            else {
                successCall = false
                failure(NSError())
            }
            
        }

    
    }
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSuccesViewCallback() {
        let model = DirectionsManagerMock(request: true)
        let view = DirectionsListViewMock()
        let presenter = DirectionListPresenterImpl(model: model, view: view)
        presenter.loadDirections(userNick: "vforvad")
        XCTAssertTrue(view.successCalled)
    }
    
    func testFailureViewCallback() {
        let model = DirectionsManagerMock(request: false)
        let view = DirectionsListViewMock()
        let presenter = DirectionListPresenterImpl(model: model, view: view)
        presenter.loadDirections(userNick: "vforvad")
        XCTAssertFalse(view.successCalled)
    }
    
    func testSuccessModelCallback() {
        let model = DirectionsManagerMock(request: true)
        let view = DirectionsListViewMock()
        let presenter = DirectionListPresenterImpl(model: model, view: view)
        presenter.loadDirections(userNick: "vforvad")
        XCTAssertTrue(model.successCall)
    }
    
    func testFailedModelCallback() {
        let model = DirectionsManagerMock(request: false)
        let view = DirectionsListViewMock()
        let presenter = DirectionListPresenterImpl(model: model, view: view)
        presenter.loadDirections(userNick: "vforvad")
        XCTAssertFalse(model.successCall)
    }
    
}
