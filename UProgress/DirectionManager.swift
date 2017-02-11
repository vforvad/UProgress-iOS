//
//  DirectionService.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire

class DirectionManager: DirectionModelProtocol {
    
    init() {
    }
    
    internal func loadDirectionsList(userNick: String, pageNumber: Int, success: @escaping (_ directions: [Direction]) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        ApiRequest.sharedInstance.get(url: "/users/\(userNick)/directions", parameters: ["page": pageNumber]).responseArray(keyPath: "directions") { (response: DataResponse<[Direction]>) in
            switch(response.result) {
            case .success(let value):
                success(value)
            case .failure(let errorValue):
                failure(errorValue as NSError)
            }
        }
    }
}
