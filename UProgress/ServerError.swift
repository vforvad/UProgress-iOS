//
//  ServerError.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 02.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class ServerError: NSObject {
    var desc: String = ""
    var status: Int?
    var params: Dictionary<String, AnyObject>?
    var formErrors: NSDictionary!
    var parentController: UIViewController?
    
    override init() {
        super.init()
    }
    
    init(parameters: NSError) {
        self.status = parameters.code
        self.desc = parameters.localizedDescription
    }
    
    init(status: Int?, description: String) {
        self.status = status
        self.desc = description
    }
    
    init(status: Int?, parameters: Dictionary<String, AnyObject>?) {
        self.status = status
        self.params = parameters
    }
    
    init(parameters: NSError!, data: NSData!) {
        self.status = parameters.code
        self.desc = parameters.localizedDescription
        do {
            self.params = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, AnyObject>
        }
        catch let error as NSError {
            self.params = nil
        }
    }
    
    init(status: Int, parameters: NSDictionary) {
        self.status = status
        self.params = parameters as! Dictionary<String, AnyObject>
    }
}
