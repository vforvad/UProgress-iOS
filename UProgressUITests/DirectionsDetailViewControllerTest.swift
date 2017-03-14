//
//  DirectionsDetailViewControllerTest.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 14.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Embassy
import EnvoyAmbassador

class DirectionsDetailViewControllerTest: BaseUITest {
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
            
            super.router["/api/v1/users/aaa/directions/[1-9]"] = JSONResponse(statusCode: 200, handler: { eviron -> Any in
                return [
                    "direction": [
                        "id": 1,
                        "title": "Domainer",
                        "description": "The JSON program is down, reboot the online pixel so we can connect the SCSI feed!",
                        "finished_steps_count": 2,
                        "percents_result": 40,
                        "updated_at": "2016-12-31T19:18:01.148Z",
                        "slug": "treeflex",
                        "steps": [
                            [
                                "id": 2,
                                "title": "Step 1",
                                "description":
                                "Step 1 description",
                                "direction_id": 1,
                                "is_done": false,
                                "updated_at": "2016-12-31T19:17:44.551Z"
                            ],
                            ["id": 2,
                             "title": "Step 2",
                             "description":
                                "Step 2 description",
                             "direction_id": 1,
                             "is_done": true,
                             "updated_at": "2016-12-31T19:17:44.551Z"
                            ]
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
        let cell = app.tables.cells.staticTexts["Domainer"]
        cell.tap()
        sleep(2)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDirectionDetailPresence() {
        XCTAssert(app.staticTexts["Domainer"].exists)
        XCTAssert(app.staticTexts["Step 1"].exists)
        XCTAssert(app.staticTexts["Step 2"].exists)
    }
    
    func testExistanceOfStepPopup() {        
        app.navigationBars.buttons.element(boundBy: 2).tap()
        sleep(1)
        XCTAssert(app.textFields["Title"].exists)
        XCTAssert(app.textViews["Description"].exists)
        XCTAssert(app.buttons["Save"].exists)
        XCTAssert(app.buttons["Cancel"].exists)
    }
}
