//
//  DirectionResponse.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import ObjectMapper

class DirectionResponse: Mappable {
    var directions: [Direction]!
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        directions <- map["directions"]
    }
}
