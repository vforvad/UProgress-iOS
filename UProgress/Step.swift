//
//  Step.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import ObjectMapper

class Step: Mappable {
    var id: Int!
    var title: String!
    var description: String!
    var updatedAt: Date!
    var direction: Direction!
    
    required init?() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        direction <- map["direction"]
        
        let stringFromDate = map["updated_at"].currentValue as! String
        if let dateFromString = stringFromDate.dateFromISO8601 {
            updatedAt = dateFromString
        }
    }
}
