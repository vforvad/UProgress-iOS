//
//  UProgressUITests.swift
//  UProgressUITests
//
//  Created by Vadim Sokoltsov on 28.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import XCTest
import KeychainSwift

class UProgressUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        var keychain = KeychainSwift()
        keychain.delete("uprogresstoken")
        ApiRequest.sharedInstance.mockedUrl = "http://www.mocky.io/v2/58b6976911000038109c41c6"
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        /*
         EXAMPLE JSON SCHEME
        {
            directions: [
            {
            "id"=>318,
            "title"=>"Direction new",
            "description"=>"Salsa mlwkmdlkawlkdmlawkdml",
            "created_at"=>Mon, 27 Feb 2017 15:28:56 UTC +00:00,
            "updated_at"=>Mon, 27 Feb 2017 15:28:56 UTC +00:00,
            "user_id"=>21,
            "slug"=>"direction_new",
            "steps_count"=>0,
            "finished_steps_count"=>0
            },
            {
            "id"=>317,
            "title"=>"Direction new",
            "description"=>"Salsa mlwkmdlkawlkdmlawkdml",
            "created_at"=>Mon, 27 Feb 2017 15:24:03 UTC +00:00,
            "updated_at"=>Mon, 27 Feb 2017 15:24:03 UTC +00:00,
            "user_id"=>21,
            "slug"=>"direction_new",
            "steps_count"=>0,
            "finished_steps_count"=>0
            },
            {
            "id"=>316,
            "title"=>"114",
            "description"=>"112",
            "created_at"=>Fri, 06 Jan 2017 19:03:02 UTC +00:00,
            "updated_at"=>Sun, 19 Feb 2017 15:23:42 UTC +00:00,
            "user_id"=>21,
            "slug"=>"114",
            "steps_count"=>2,
            "finished_steps_count"=>0
            }
            ]    
        }
         */
    }
    
}
