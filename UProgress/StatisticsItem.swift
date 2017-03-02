//
//  StatisticsItem.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 28.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import ObjectMapper

class StatisticsItem: Mappable {
    var label: String!
    var value: Double!
    var color: String!
    
    required init?() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        label <- map["label"]
        value <- map["value"]
        color <- map["color"]
        
    }
}
