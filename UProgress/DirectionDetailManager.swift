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
    internal func loadDirection(userNick: String, directionId: String!, success: @escaping (_ direction: Direction) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        let url = "/users/\(userNick)/directions/" + directionId
        ApiRequest.sharedInstance.get(url: url, parameters: [:]).responseJSON{ response in
            if response.response?.statusCode == 200 {
                let directionObject = response.result.value! as! Dictionary<String, Any>
                let direction = Mapper<Direction>().map(JSONObject: directionObject["direction"])
                success(direction!)
            } else {
                let error = response.result.value as? Dictionary<String, AnyObject>
                failure(ServerError(status: response.response!.statusCode, parameters: error))
            }
        }
    }
    
    internal func createStep(userNick: String, directionId: String!, parameters: Dictionary<String, AnyObject>, success: @escaping (_ step: Step) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        let url = "/users/\(userNick)/directions/" + directionId + "/steps"
        ApiRequest.sharedInstance.post(url: url, parameters: ["step": parameters] as NSDictionary).responseJSON { response  in
            if response.response?.statusCode == 200 {
                let stepObject = response.result.value! as! Dictionary<String, Any>
                let step = Mapper<Step>().map(JSONObject: stepObject["step"])
                success(step!)
            } else {
                let error = response.result.value as? Dictionary<String, AnyObject>
                failure(ServerError(status: response.response!.statusCode, parameters: error))
            }
        }
    }
    
    internal func updateStep(userNick: String, directionId: String!, stepId: String!, parameters: Dictionary<String, AnyObject>, success: @escaping (_ step: Step) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        let url = "/users/\(userNick)/directions/" + directionId + "/steps/" + stepId
        ApiRequest.sharedInstance.put(url: url, parameters: ["step": parameters] as NSDictionary).responseJSON { response  in
            if response.response?.statusCode == 200 {
                let stepObject = response.result.value! as! Dictionary<String, Any>
                let step = Mapper<Step>().map(JSONObject: stepObject["step"])
                success(step!)
            } else {
                let error = response.result.value as? Dictionary<String, AnyObject>
                failure(ServerError(status: response.response!.statusCode, parameters: error))
            }
        }
    }
    
    internal func deleteStep(userNick: String, directionId: String!, stepId: String!, success: @escaping (_ step: Step) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        let url = "/users/\(userNick)/directions/" + directionId + "/steps/" + stepId
        ApiRequest.sharedInstance.delete(url: url, parameters: [:]).responseJSON { response  in
            if response.response?.statusCode == 200 {
                let stepObject = response.result.value! as! Dictionary<String, Any>
                let step = Mapper<Step>().map(JSONObject: stepObject["step"])
                success(step!)
            } else {
                let error = response.result.value as? Dictionary<String, AnyObject>
                failure(ServerError(status: response.response!.statusCode, parameters: error))
            }
        }
    }
}
