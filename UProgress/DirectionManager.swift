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
    
    internal func loadDirectionsList(userNick: String, pageNumber: Int) -> DataRequest {
        return ApiRequest.sharedInstance.get(url: "/users/\(userNick)/directions", parameters: ["page": pageNumber])
    }
}
