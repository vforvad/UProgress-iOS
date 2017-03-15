//
//  ProfileViewControllerTest.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 15.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Embassy
import EnvoyAmbassador

class ProfileViewControllerTest: BaseUITest {
    override func setUp() {
        super.setUpWithHandler() {
            super.router["/api/v1/sessions/current"] = JSONResponse(statusCode: 200, handler: { eviron -> Any in
                return [
                    "current_user": [
                        "id": 1,
                        "email": "example@mail.com",
                        "nick": "aaa",
                        "attachment": [
                            "id": 1,
                            "url": "http://lurkmore.so/images/thumb/2/2d/Trollface_HD.png/250px-Trollface_HD.png",
                            "attachable_type": "User",
                            "attachable_id": 1
                        ]
                    ]
                ]
            })
        }
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        let cell = app.tables.cells.staticTexts["aaa"]
        cell.tap()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDisplayingOfUserProfileInfo() {
        XCTAssert(app.staticTexts["example@mail.com"].exists)
        XCTAssert(app.staticTexts["@aaa"].exists)
    }
    
    func testAppearingOfUserUpdatePopup() {
        app.navigationBars.buttons.element(boundBy: 2).tap()
        app.sheets["Choose an action"].buttons["Edit"].tap()
        
        XCTAssert(app.textFields["First name"].exists)
        XCTAssert(app.textFields["Last name"].exists)
        XCTAssert(app.textFields["Email"].exists)
        XCTAssert(app.textFields["Location"].exists)
        XCTAssert(app.textViews["Few words about yourself"].exists)
    }
    
    func testSuccessUserProfileUpdate() {
        
        super.router["/api/v1/users/1"] = JSONResponse(statusCode: 200, handler: { eviron -> Any in
            return [
                "current_user": [
                    "id": 1,
                    "email": "example1@mail.com",
                    "nick": "aaa",
                    "attachment": [
                        "id": 1,
                        "attachable_id": 1,
                        "url": "http://lurkmore.so/images/thumb/2/2d/Trollface_HD.png/250px-Trollface_HD.png",
                        "attachable_type": "User"
                    ]
                ]
            ]
        })
        
        app.navigationBars.buttons.element(boundBy: 2).tap()
        app.sheets["Choose an action"].buttons["Edit"].tap()
        
        let email = app.textFields["Email"];
        
        email.tap()
        email.typeText("example1@mail.com")
        
        app.buttons["Save"].tap()
        
        sleep(1)
        
        XCTAssert(app.staticTexts["example1@mail.com"].exists)
    }
    
    func testFailedUserProfileUpdate() {
        
        super.router["/api/v1/users/1"] = JSONResponse(statusCode: 422, handler: { eviron -> Any in
            return [
                "errors": [
                    "email": ["Can't be blank"]
                ]
            ]
        })
        
        app.navigationBars.buttons.element(boundBy: 2).tap()
        app.sheets["Choose an action"].buttons["Edit"].tap()
        
        app.buttons["Save"].tap()
        
        sleep(1)
        
        XCTAssert(app.staticTexts["Can't be blank"].exists)
    }
}
