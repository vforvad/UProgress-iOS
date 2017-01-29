//
//  UProgressTests.swift
//  UProgressTests
//
//  Created by Vadim Sokoltsov on 28.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import XCTest
import Alamofire
import Mockingjay
@testable import UProgress

class UProgressTests: XCTestCase {
    
    class DirectionViewMock: DirectionsListViewController{
        var directionsLoad = false
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        
        override func successDirectionsLoad(directions: [Direction]!) {
            directionsLoad = true
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
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssert(1 + 1 == 2)
    }
    
    func testServerResponse() {
    
        let body = [ "directions": [ ["id": 1] ] ]
//        stub(condition: isHost("dockerhost")) { _ in
//            let obj = [ "directions": [["key1": "value1"]]]
//            return OHHTTPStubsResponse(JSONObject: obj, statusCode: 200, headers: nil)
//        }
        
        MockingjayProtocol.addStub(matcher: uri("http://192.168.99.100:3000/api/v1/users/vforvad/directions?page=1"), builder: json(body))
        
        var model = DirectionManager()
        var view = DirectionViewMock()
        var presenter = DirectionListPresenterImpl(model: model, view: view)
        presenter.loadDirections(userNick: "vforvad", pageNumber: 1)
        self.waitForExpectations(timeout: 5, handler: { result in
            XCTAssertTrue(view.directionsLoad)
        })
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
