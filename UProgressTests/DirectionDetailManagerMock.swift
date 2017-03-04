//
//  DirectionDetailManagerMock.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 04.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class DirectionDetailManagerMock: DirectionDetailManagerProtocol {
    var successRequest: Bool!
    var loadDirection: Bool!
    var createDirection: Bool!
    var updateDirection: Bool!
    var deleteDirection: Bool!
    
    init(request: Bool) {
        self.successRequest = request
    }
    
    func loadDirection(userNick: String, directionId: String!, success: @escaping (_ direction: Direction) -> Void, failure: @escaping (_ error: NSError) -> Void) {
        
        if successRequest! {
            loadDirection = true
            success(Direction()!)
        }
        else {
            loadDirection = false
            failure(NSError())
        }
    }
    
    func createStep(userNick: String, directionId: String!, parameters: Dictionary<String, AnyObject>, success: @escaping (_ step: Step) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        
        if successRequest! {
            createDirection = true
        }
        else {
            createDirection = false
        }
    }
    
    func updateStep(userNick: String, directionId: String!, stepId: String!, parameters: Dictionary<String, AnyObject>, success: @escaping (_ step: Step) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        
        if successRequest! {
            updateDirection = true
        }
        else {
            updateDirection = false
        }
    }
    
    func deleteStep(userNick: String, directionId: String!, stepId: String!, success: @escaping (_ step: Step) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        
        if successRequest! {
            deleteDirection = true
        }
        else {
           deleteDirection = false
        }
    }
}
