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

class UProgressUITests: XCTestCase {
    var app: XCUIApplication!
    var eventLoopThreadCondition: NSCondition!
    var eventLoopThread: Thread!
    var eventLoop: EventLoop!
    var server: HTTPServer!
    var router: Router!
    
    override func setUp() {
        super.setUp()
        eventLoop = try! SelectorEventLoop(selector: try! KqueueSelector())
        router = Router()
        server = DefaultHTTPServer(eventLoop: eventLoop, port: 8080, app: router.app)
        
        router["/api/v1/sessions/current"] = DataResponse(
            statusCode: 403,
            statusMessage: "unauthorized",
            contentType: "application/json",
            headers: [("Content-Type", "application/json")]
        ) { environ -> Data in
            return Data(String(describing: ["user": ""]).utf8)
        }
        
        // Start HTTP server to listen on the port
        try! server.start()
        
        eventLoopThread = Thread(target: self, selector: #selector(runEventLoop), object: nil)
        eventLoopThreadCondition = NSCondition()
        eventLoopThread.start()
        
        // Run event loop
//        loop.runForever()
        app = XCUIApplication()
//        app.launchEnvironment["\(ApiRequest.shared)]
        app.launch()
        
        continueAfterFailure = false
    
        
//        KeychainSwift().set("123456", forKey: "uprogresstoken")
//        let path = Bundle(for: type(of: self)).path(forResource: "current_user", ofType: "json")!
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
        server.stopAndWait()
        eventLoopThreadCondition.lock()
        eventLoop.stop()
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
    
    @objc private func runEventLoop() {
        eventLoop.runForever()
        eventLoopThreadCondition.lock()
        eventLoopThreadCondition.signal()
        eventLoopThreadCondition.unlock()
    }
}
