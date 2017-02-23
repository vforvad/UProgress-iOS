//
//  ProfileManager.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 23.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ProfileManager: ProfileManagerProtocol {
    internal func updateProfile(userId: String!, profileParameters: Dictionary<String, AnyObject>, success: @escaping (_ currentUser: User) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        ApiRequest.sharedInstance.put(url: "/users/" + userId, parameters: ["user": profileParameters] as NSDictionary).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                let profileObject = response.result.value! as! Dictionary<String, Any>
                let user = Mapper<User>().map(JSONObject: profileObject["current_user"])
                success(user!)
            }
            else {
                let error = response.result.value as! NSDictionary
                let errorMessage = error.object(forKey: "errors") as! NSDictionary
                failure(ServerError(status: response.response!.statusCode, parameters: errorMessage))
            }
        }
    }
}
