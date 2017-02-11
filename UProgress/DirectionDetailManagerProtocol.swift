//
//  DirectionDetailManagerProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 11.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol DirectionDetailManagerProtocol {
    func loadDirection(userNick: String, directionId: String!, success: @escaping (_ direction: Direction) -> Void, failure: @escaping (_ error: NSError) -> Void)
    
    func createStep(userNick: String, directionId: String!, parameters: Dictionary<String, AnyObject>, success: @escaping (_ step: Step) -> Void, failure: @escaping (_ error: ServerError) -> Void)
}
