//
//  BaseFunctions.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class BaseTest: QuickSpec {
    override func spec() {
        super.spec()
        let path = Bundle(for: type(of: self)).path(forResource: "current_user", ofType: "json")!
        let data = NSData(contentsOfFile: path)!
        MockingjayProtocol.addStub(matcher: uri("\(ApiRequest.sharedInstance.host)/api/v1/sessions/current"), builder: jsonData(data as Data))
        
        let imagePath = Bundle(for: type(of: self)).path(forResource: "shut_up_and_take_my_money", ofType: "jpg")!
        let imageData = NSData(contentsOfFile: imagePath)!
        self.stub(uri("http:1234/image.jpg"), jsonData(imageData as Data))
    }
}
