//
//  ApiRequest.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

public enum Method: String {
    case GET, HEAD, POST, PUT, PATCH, DELETE
}

class ApiRequest: NSObject {
    var host = "http://dockerhost:3000"
    
    class var sharedInstance: ApiRequest {
        struct Singleton {
            static let instance: ApiRequest = ApiRequest()
        }
        
        return Singleton.instance
    }
    
    func get(url: String, parameters: NSDictionary) -> DataRequest {
        return request(url: url, requestType: .get, parameters: parameters)
    }
    
    func post(url: String, parameters: NSDictionary) -> DataRequest {
        return request(url: url, requestType: .post, parameters: parameters)
    }
    
    func request(url: String, requestType: HTTPMethod, parameters: NSDictionary) -> DataRequest {
        var request: DataRequest!
        
        var headers = [
            "Content-Type": "application/json",
        ]
        
        
        if requestType != .get {
            request =  Alamofire.request(self.defineFullUrl(url: url), method: requestType, parameters: parameters as! Parameters, encoding: JSONEncoding.default, headers: headers)
        }
        else {
            request =  Alamofire.request(self.defineFullUrl(url: url), method: requestType, parameters: parameters as! Parameters, headers: headers)
        }
        
        return request
    }
    
    func defineFullUrl(url: String!) -> String {
        return "\(host)/api/v1\(url!)"
    }
}
