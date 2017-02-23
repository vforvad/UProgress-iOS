//
//  Attachment.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 23.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import ObjectMapper

class Attachment: Mappable {
    var id: Int!
    var attachableId: Int!
    var attachableType: String!
    var url: String!
    
    
    required init?() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        attachableId <- map["attachable_id"]
        attachableType <- map["attachable_type"]
        url <- map["url"]
    }
    
    func toDict() -> Dictionary<String, Any> {
        return [
            "id": id,
            "attachable_id": attachableId,
            "attachable_type": attachableType,
            "url": url
        ]
    }
}
