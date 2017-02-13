//
//  Direction.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import ObjectMapper

class Direction: Mappable {
    var id: Int!
    var title: String!
    var description: String!
    var percentsResult: Int!
    var updatedAt: Date!
    var steps: [Step]?
    
    required init?() {
    
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        percentsResult <- map["percents_result"]
        steps <- map["steps"]
        
        let stringFromDate = map["updated_at"].currentValue as! String
        if let dateFromString = stringFromDate.dateFromISO8601 {
            updatedAt = dateFromString
        }
    }

}
