//
//  UProgressUITests.swift
//  UProgressUITests
//
//  Created by Vadim Sokoltsov on 28.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import XCTest
//import Mockingjay
import KeychainSwift
import Embassy
import EnvoyAmbassador

class UProgressUITests: BaseUITest {
    
    override func setUp() {
        super.setUpWithHandler() {
            super.router["/api/v1/sessions/current"] = DataResponse(
                statusCode: 403,
                statusMessage: "unauthorized",
                contentType: "application/json",
                headers: [("Content-Type", "application/json")]
            ) { environ -> Data in
                return Data(String(describing: ["user": ""]).utf8)
            }
        }
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testEmailFieldExists() {
        let textField = app.textFields["Email"]
        XCTAssert(textField.exists)
    }
    
    func testPasswordFieldExists() {
        let passwordField = app.secureTextFields["Password"]
        XCTAssert(passwordField.exists)
    }
    
    func testFailedAuthorizationFlow() {
        router["/api/v1/sessions"] = DelayResponse(JSONResponse(statusCode: 403, handler: { _ -> Any in
            return [
                "errors": [
                    "email": ["Can't be blank"]
                ]
            ]
        }))

        
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let button = app.buttons["Sign in!"]
        
        emailField.tap()
        emailField.typeText("example@mail.com")
        passwordField.tap()
        passwordField.typeText("password")
        button.tap()
        sleep(5)
        XCTAssert(self.app.staticTexts["Can't be blank"].exists)

        
    }
}
