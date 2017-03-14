//
//  DirectionsListViewControllerTest.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 14.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Embassy
import EnvoyAmbassador

class DirectionsListViewControllerTest: BaseUITest {
    override func setUp() {
        super.setUpWithHandler() {
            super.router["/api/v1/sessions/current"] = JSONResponse(statusCode: 200, handler: { eviron -> Any in
              return [
                "current_user": [
                    "id": 1,
                    "email": "example@mail.com",
                    "nick": "aaa",
                    "attachment": [
                        "url": "http://lurkmore.so/images/thumb/2/2d/Trollface_HD.png/250px-Trollface_HD.png"
                    ]
                ]
              ]
            })
            
            super.router["/api/v1/users/aaa/directions"] = JSONResponse(statusCode: 200, handler: { eviron -> Any in
                return [
                    "directions": [
                        [
                         "id": 1,
                         "title": "Domainer",
                         "description": "The JSON program is down, reboot the online pixel so we can connect the SCSI feed!",
                            "finished_steps_count": 2,
                            "percents_result": 40,
                            "updated_at": "2016-12-31T19:18:01.148Z",
                            "slug": "treeflex"
                        ],
                        [
                            "id": 2,
                            "title": "Domainer 1",
                            "description": "The JSON program is down, reboot the online pixel so we can connect the SCSI feed!",
                            "finished_steps_count": 2,
                            "percents_result": 40,
                            "updated_at": "2016-12-31T19:18:01.148Z",
                            "slug": "treeflex"
                        ],
                        [
                            "id": 3,
                            "title": "Domainer 2",
                            "description": "The JSON program is down, reboot the online pixel so we can connect the SCSI feed!",
                            "finished_steps_count": 2,
                            "percents_result": 40,
                            "updated_at": "2016-12-31T19:18:01.148Z",
                            "slug": "treeflex"
                        ]
                    ]
                ]
            })
        }
    }
    
    func testDirectionsListPresence() {
        XCTAssert(app.staticTexts["Domainer"].exists)
        XCTAssert(app.staticTexts["Domainer 1"].exists)
        XCTAssert(app.staticTexts["Domainer 2"].exists)
    }
    
    func testSearch() {
        let search = app.searchFields["Search"]
        search.tap()
        search.typeText("Domainer 1")
        XCTAssert(app.staticTexts["Domainer 1"].exists)
        XCTAssertFalse(app.staticTexts["Domainer"].exists)
        XCTAssertFalse(app.staticTexts["Domainer 2"].exists)
    }
    
    func testExistanceOfDirectionsPopup() {
        app.navigationBars.buttons.element(boundBy: 1).tap()
        XCTAssert(app.textFields["Title"].exists)
        XCTAssert(app.textViews["Description"].exists)
    }
    
    func testFailedCreationOfDirection() {
        super.router["/api/v1/users/aaa/directions"] = JSONResponse(statusCode: 422, handler: { eviron -> Any in
            return [
                "errors": [
                    "title": ["Can't be blank"],
                    "description": ["Can't be blank"]
                ]
            ]
        })
        
        app.navigationBars.buttons.element(boundBy: 1).tap()
        
        let save = app.buttons["Save"]
        save.tap()
        sleep(5)
        XCTAssert(app.staticTexts["Can't be blank"].exists)
    }
    
    override func tearDown() {
        super.tearDown()
    }
}
