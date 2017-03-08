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

class UProgressUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
        
//        KeychainSwift().set("123456", forKey: "uprogresstoken")
//        let path = Bundle(for: type(of: self)).path(forResource: "current_user", ofType: "json")!
//
//        let data = NSData(contentsOfFile: path)!
//        MockingjayProtocol.addStub(matcher: uri("\(ApiRequest.sharedInstance.host)/api/v1/sessions/current"), builder: jsonData(data as Data))
//        
//        let imagePath = Bundle(for: type(of: self)).path(forResource: "shut_up_and_take_my_money", ofType: "jpg")!
//        let imageData = NSData(contentsOfFile: imagePath)!
//        self.stub(uri("http://1234/image.jpg"), jsonData(imageData as Data))
//        
//        let p = Bundle(for: type(of: self)).path(forResource: "directions", ofType: "json")!
//        let d = NSData(contentsOfFile: p)!
//        self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/users/vforvad/directions?page=1"), jsonData(d as Data))
//        
//        let pathSignIn = Bundle(for: type(of: self)).path(forResource: "token", ofType: "json")!
//        let dataSignIn = NSData(contentsOfFile: pathSignIn)!
//        self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/sessions"), jsonData(dataSignIn as Data))
//        stub(condition: isPath("/api/v1/sessions"),response: { _ in
//            let stubPath = OHPathForFile("token.json", type(of: self))
//            return OHHTTPStubsResponse(fileAtPath: stubPath!, statusCode: 200, headers: ["Content-Type": "application/json"])
//        })
        
//        stub(condition: isHost("\(ApiRequest.sharedInstance.host)/api/v1/current"), response: { _ in
//            let stubPath = OHPathForFile("current_user.json", type(of: self))
//            return fixture(filePath: stubPath!, headers: ["Content-Type" as NSObject: "application/json" as AnyObject])
//        })
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
    
    func testSuccessAuthorizationFlow() {
//        stub(condition: isPath("/api/v1/sessions"),response: { _ in
//            let stubPath = OHPathForFile("token.json", type(of: self))
//            return OHHTTPStubsResponse(fileAtPath: stubPath!, statusCode: 200, headers: ["Content-Type": "application/json"])
//        })
        
        let emailField = app.textFields["Email"]
        let passwordField = app.secureTextFields["Password"]
        let button = app.buttons["Sign in!"]
        
        emailField.tap()
        emailField.typeText("example@mail.com")
        passwordField.tap()
        passwordField.typeText("password")
        button.tap()
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssert(app.staticTexts["example@mail.com"].exists)
    }
}
