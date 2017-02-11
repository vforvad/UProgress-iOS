//
//  DirectionDetailManager.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 11.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire

class DirectionDetailManager: DirectionDetailManagerProtocol {
    init() {}
    
    internal func loadDirection(userNick: String, directionId: String!, success: @escaping (_ direction: Direction) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        let direction = "\(directionId)"
        let url = "/users/\(userNick)/directions/" + directionId
        ApiRequest.sharedInstance.get(url: url, parameters: [:]).responseObject(keyPath: "direction") { (response: DataResponse<Direction>) in
            switch(response.result) {
            case .success(let value):
                success(value)
            case .failure(let errorValue):
                failure(errorValue as NSError)
            }
        }
    }
}
