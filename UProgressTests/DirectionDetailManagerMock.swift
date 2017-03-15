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
    var createStep: Bool!
    var updateStep: Bool!
    var deleteStep: Bool!
    
    init(request: Bool) {
        self.successRequest = request
    }
    
    func loadDirection(userNick: String, directionId: String!, success: @escaping (_ direction: Direction) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        
        if successRequest! {
            loadDirection = true
            success(Direction()!)
        }
        else {
            loadDirection = false
            failure(ServerError())
        }
    }
    
    func createStep(userNick: String, directionId: String!, parameters: Dictionary<String, AnyObject>, success: @escaping (_ step: Step) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        
        if successRequest! {
            createStep = true
            success(Step()!)
        }
        else {
            createStep = false
            failure(ServerError())
        }
    }
    
    func updateStep(userNick: String, directionId: String!, stepId: String!, parameters: Dictionary<String, AnyObject>, success: @escaping (_ step: Step) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        
        if successRequest! {
            updateStep = true
            success(Step()!)
        }
        else {
            updateStep = false
            failure(ServerError())
        }
    }
    
    func deleteStep(userNick: String, directionId: String!, stepId: String!, success: @escaping (_ step: Step) -> Void, failure: @escaping (_ error: ServerError) -> Void) {
        
        if successRequest! {
            deleteStep = true
            success(Step()!)
        }
        else {
           deleteStep = false
            failure(ServerError())
        }
    }
}
