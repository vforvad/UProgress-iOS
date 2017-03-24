//
//  DirectionsDetailPresenterProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol DirectionsDetailPresenterProtocol {
    func loadDirection(userNick: String!, directionId: String!)
    func updateStep(userId: String!, directionId: String!, stepId: String!, parameters: Dictionary<String, AnyObject>)
    func deleteStep(userId: String!, directionId: String!, stepId: String!)
    func refreshDirection(userNick: String!, directionId: String!)
}
