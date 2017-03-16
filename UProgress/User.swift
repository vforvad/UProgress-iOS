//
//  User.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    var id: Int!
    var firstName: String!
    var lastName: String!
    var nick: String!
    var email: String!
    var avatarUrl: String!
    var location: String!
    var description: String!
    var attachment: Attachment!
    
    required init?() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        nick <- map["nick"]
        email <- map["email"]
        avatarUrl <- map["attachment.url"]
        location <- map["location"]
        description <- map["description"]
        attachment <- map["attachment"]
    }
    
    func getFullName() -> String {
        var correctName: String!
        
        if firstName != nil && lastName != nil {
                correctName = firstName + " " + lastName
        } else {
                correctName = email
        }
        
        return correctName
    }
    
    func getCorrectNick() -> String {
        return "@" + nick
    }
    
    func attributesDictionary() -> [Dictionary<String, String>] {
        var list: [Dictionary<String, String>]! = []
        if firstName != nil && lastName != nil {
            list.append(["title": "email", "value": email])
        }
        if location != nil {
            list.append(["title": "location", "value": location])
        }
        
        if description != nil {
            list.append(["title": "description", "value": description])
        }
        return list
    }
}
