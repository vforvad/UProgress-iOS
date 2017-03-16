//
//  UProgressUITests.swift
//  UProgressUITests
//
//  Created by Vadim Sokoltsov on 28.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import XCTest
import Embassy
import EnvoyAmbassador

class AuthorizationViewControllerTest: BaseUITest {
    
    override func setUp() {
        super.setUpWithHandler() {
                super.router["/api/v1/sessions/current"] = JSONResponse(statusCode: 403, handler: { eviron -> Any in
                    return [
                        "user": ""
                    ]
                })
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
        super.router["/api/v1/sessions"] = DelayResponse(JSONResponse(statusCode: 403, handler: { _ -> Any in
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
        sleep(2)
        XCTAssert(self.app.staticTexts["Can't be blank"].exists)

        
    }
    
    func testSuccessAuthorizationFlow() {
        super.router["/api/v1/sessions/([a-zA-Z])"] = JSONResponse(statusCode: 200, handler: { _ -> Any in
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
        
        super.router["/api/v1/sessions"] = JSONResponse(statusCode: 200, handler: { _ -> Any in
            return [
                "token": "12345"
            ]
        })
        
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let button = app.buttons["Sign in!"]
        
        emailField.tap()
        emailField.typeText("example@mail.com")
        passwordField.tap()
        passwordField.typeText("password")
        button.tap()
        sleep(1)
        XCTAssert(self.app.staticTexts["@aaa"].exists)
    }
    
    func testSuccessRegistrationFlow() {
        super.router["/api/v1/sessions/([a-zA-Z])"] = JSONResponse(statusCode: 200, handler: { _ -> Any in
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
        
        super.router["/api/v1/registrations"] = JSONResponse(statusCode: 200, handler: { _ -> Any in
            return [
                "token": "12345"
            ]
        })
        
        let segment = app.buttons["Registration"]
        segment.tap()
        
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let button = app.buttons["Sign up!"]
        
        emailField.tap()
        emailField.typeText("example@mail.com")
        passwordField.tap()
        passwordField.typeText("password")
        app.swipeUp()
        button.tap()
        sleep(1)
        XCTAssert(self.app.staticTexts["@aaa"].exists)
    }
    
    func testFailedRegistrationFlow() {
        super.router["/api/v1/registrations"] = JSONResponse(statusCode: 422, handler: { _ -> Any in
            return [
                "errors": [
                    "email": ["Can't be blank"]
                ]
            ]
        })
        
        let segment = app.buttons["Registration"]
        segment.tap()
        
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let button = app.buttons["Sign up!"]
        
        emailField.tap()
        emailField.typeText("")
        passwordField.tap()
        passwordField.typeText("password")
        app.swipeUp()
        button.tap()
        sleep(1)
        XCTAssert(self.app.staticTexts["Can't be blank"].exists)
    }
}
