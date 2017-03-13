//
//  BaseUITest.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 13.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Embassy
import EnvoyAmbassador

class BaseUITest: XCTestCase {
    var app: XCUIApplication!
    var eventLoopThreadCondition: NSCondition!
    var eventLoopThread: Thread!
    var eventLoop: EventLoop!
    var server: HTTPServer!
    var router: Router!
    
    override func setUp() {
        super.setUp()
        
    }
    
    func setUpWithHandler(blockHandler: (() -> Void)?) {
        super.setUp()
        eventLoop = try! SelectorEventLoop(selector: try! KqueueSelector())
        router = Router()
        server = DefaultHTTPServer(eventLoop: eventLoop, port: 8080, app: router.app)
        router["/api/v1/sessions/current"] = DataResponse(
            statusCode: 200,
            statusMessage: "unauthorized",
            contentType: "application/json",
            headers: [("Content-Type", "application/json")]
        ) { environ -> Data in
            return Data(String(describing: ["current_user": [
                "id": 1,
                "nick": "aaa"
                ]]).utf8)
        }
        
        // Start HTTP server to listen on the port
        try! server.start()
        
        eventLoopThread = Thread(target: self, selector: #selector(runEventLoop), object: nil)
        eventLoopThreadCondition = NSCondition()
        eventLoopThread.start()
        
        app = XCUIApplication()
        app.launchEnvironment["UITests"] = "True"
        continueAfterFailure = false
        if blockHandler != nil {
            blockHandler!()
        }
        app.launch()
        
    }
    
    override func tearDown() {
        super.tearDown()
        server.stopAndWait()
        eventLoopThreadCondition.lock()
        eventLoop.stop()
    }
    
    @objc private func runEventLoop() {
        eventLoop.runForever()
        eventLoopThreadCondition.lock()
        eventLoopThreadCondition.signal()
        eventLoopThreadCondition.unlock()
    }
}
