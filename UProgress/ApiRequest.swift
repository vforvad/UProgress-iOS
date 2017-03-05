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
import KeychainSwift

public enum Method: String {
    case GET, HEAD, POST, PUT, PATCH, DELETE
}

class ApiRequest: NSObject {
    var host = Bundle.main.infoDictionary!["API_ENDPOINT"] as! String
    var keychain = KeychainSwift()
    var mockedUrl: String!
    
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
    
    func put(url: String, parameters: NSDictionary) -> DataRequest {
        return request(url: url, requestType: .put, parameters: parameters)
    }
    
    func delete(url: String, parameters: NSDictionary) -> DataRequest {
        return request(url: url, requestType: .delete, parameters: parameters)
    }
    
    func request(url: String, requestType: HTTPMethod, parameters: NSDictionary) -> DataRequest {
        var request: DataRequest!
        let tokenName = "uprogresstoken"
        let token = keychain.get(tokenName)
        
        var headers = [
            "Content-Type": "application/json",
        ]
        
        if (token != nil) {
            headers[tokenName] = token
        }
        
        if requestType != .get {
            request =  Alamofire.request(self.defineFullUrl(url: url), method: requestType, parameters: (parameters as! Parameters), encoding: JSONEncoding.default, headers: headers)
        }
        else {
            request =  Alamofire.request(self.defineFullUrl(url: url), method: requestType, parameters: (parameters as! Parameters), headers: headers)
        }
        
        DataRequest.addAcceptableImageContentTypes(["image/jpg", "image/png", "application/xml"])
        return request
    }
    
    func defineFullUrl(url: String!) -> String {
        if let mock = mockedUrl {
            return mock
        }
        return "\(host)/api/v1\(url!)"
    }
}
