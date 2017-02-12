//
//  DirectionDetailManager.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 11.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class DirectionDetailManager: DirectionDetailManagerProtocol {
    init() {}
    
    internal func loadDirection(userNick: String, directionId: String!, success: @escaping (_ direction: Direction) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        let direction = "\(directionId)"
        let url = "/users/\(userNick)/directions/" + directionId
        ApiRequest.sharedInstance.get(url: url, parameters: [:]).responseObject(keyPath: "direction") { (response: DataResponse<Direction>) in
            switch(response.result) {
            case .success(let value):
                success(value)
            case .failure(let errorValue):
                failure(errorValue as NSError)
            }
        }
    }
    
    internal func createStep(userNick: String, directionId: String!, parameters: Dictionary<String, AnyObject>, success: @escaping (_ step: Step) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        let direction = "\(directionId)"
        let url = "/users/\(userNick)/directions/" + directionId + "/steps"
        ApiRequest.sharedInstance.post(url: url, parameters: ["step": parameters] as NSDictionary).responseJSON { response  in
            if response.response?.statusCode == 200 {
                let stepObject = response.result.value! as! Dictionary<String, Any>
                let step = Mapper<Step>().map(JSONObject: stepObject["step"])
                success(step!)
            } else {
                let stepError = response.result.value! as! Dictionary<String, Any>
                failure(ServerError(status: response.response!.statusCode, parameters: stepError["errors"] as! NSDictionary))
            }
        }
    }
}
