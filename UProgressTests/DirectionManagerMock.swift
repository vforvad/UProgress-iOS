//
//  DirectionManagerMock.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 03.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class DirectionsManagerMock: DirectionModelProtocol {
    var successCall: Bool!
    var successRequest = false
    var successCreate: Bool!
    
    init(request: Bool) {
        self.successRequest = request
    }
    
    internal func loadDirectionsList(userNick: String, pageNumber: Int, success: @escaping ([Direction]) -> Void, failure: @escaping (NSError) -> Void) {
        var directions: [Direction]! = [Direction()!]
        if successRequest {
            successCall = true
            success(directions)
        }
        else {
            successCall = false
            failure(NSError())
        }
        
    }
    
    internal func createDirection(userNick: String, parameters: Dictionary<String, Any>, success: @escaping (_ direction: Direction) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        if successRequest {
            successCreate = true
            success(Direction()!)
        }
        else {
            successCreate = false
            failure(ServerError())
        }
    }
}
