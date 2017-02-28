//
//  StatisticsManager.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 28.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class StatisticsManager: StatisticsManagerProtocol {
    internal func loadStatistics(userId: String, success: @escaping (_ statistics: StatisticsInfo) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        let url = "/users/\(userId)/statistics"
        ApiRequest.sharedInstance.get(url: url, parameters: [:]).responseJSON { response in
            if response.response?.statusCode == 200 {
                let statObject = response.result.value! as! Dictionary<String, Any>
                let statistics = Mapper<StatisticsInfo>().map(JSONObject: statObject["statistics"])
                success(statistics!)
            }
            else {
                let stepError = response.result.value! as! Dictionary<String, Any>
                failure(ServerError(status: response.response!.statusCode, parameters: stepError["errors"] as! NSDictionary))
            }
        }
    }
}
