//
//  AttachmentModelSpec.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 08.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingjay

class AttachmentManagerSpec: BaseTest {
    let model = AttachmentManager()
    var loadedAttachment: Attachment!
    
    override func spec() {
        super.spec()
        
        describe("uploadImage()") {
            context("with valid attributes") {
                beforeEach {
                    let path = Bundle(for: type(of: self)).path(forResource: "attachment", ofType: "json")!
                    let data = NSData(contentsOfFile: path)!
                    let imagePath = Bundle(for: type(of: self)).path(forResource: "shut_up_and_take_my_money", ofType: "jpg")!
                    self.stub(uri("\(ApiRequest.sharedInstance.host)/api/v1/attachments"), jsonData(data as Data))
                    
                        var image = UIImage(contentsOfFile: imagePath)
                        self.model.uploadImage(image: image, attachableId: 1, attachableType: "User",
                        success: { attachment in
                            self.loadedAttachment = attachment
                        },
                        failure: { error in
                            
                        })
                    
                }
                
                it("receives attachment") {
                    expect(self.loadedAttachment).toEventuallyNot(beNil(), timeout: 10.0)
                }
                
            }
            
            context("with invalid attributes") {
                // TODO - handle error case
            }
        }
    }
}
