//
//  StatisticsInfo.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 28.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import ObjectMapper

class StatisticsInfo: Mappable {
    var directions: [StatisticsItem]!
    var steps: [StatisticsItem]!
    var directionSteps: [StatisticsItem]!
    
    required init?() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        directions <- map["directions"]
        steps <- map["steps"]
        directionSteps <- map["directions_steps"]
    }
}
