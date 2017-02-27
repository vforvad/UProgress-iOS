//
//  DirectionService.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class DirectionManager: DirectionModelProtocol {
    
    init() {
    }
    
    internal func loadDirectionsList(userNick: String, pageNumber: Int, success: @escaping (_ directions: [Direction]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        ApiRequest.sharedInstance.get(url: "/users/\(userNick)/directions", parameters: ["page": pageNumber]).responseArray(keyPath: "directions") { (response: DataResponse<[Direction]>) in
            switch(response.result) {
            case .success(let value):
                success(value)
            case .failure(let errorValue):
                failure(errorValue as NSError)
            }
        }
    }
    
    internal func createDirection(userNick: String, parameters: Dictionary<String, Any>, success: @escaping (_ direction: Direction) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        ApiRequest.sharedInstance.post(url: "/users/\(userNick)/directions", parameters: parameters as NSDictionary).responseJSON {
            response in
            if response.response?.statusCode == 200 {
                let directionObject = response.result.value! as! Dictionary<String, Any>
                let direction = Mapper<Direction>().map(JSONObject: directionObject["direction"])
                success(direction!)
            } else {
                let stepError = response.result.value! as! Dictionary<String, Any>
                failure(ServerError(status: response.response!.statusCode, parameters: stepError["errors"] as! NSDictionary))
            }
        }
    }
}
