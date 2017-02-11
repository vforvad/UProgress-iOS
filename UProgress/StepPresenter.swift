//
//  StepPresenter.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 11.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class StepPresenter: StepPresenterProtocol {
    private var model: DirectionDetailManagerProtocol!
    private var view: StepViewProtocol!
    
    init(model: DirectionDetailManagerProtocol, view: StepViewProtocol!) {
        self.model = model
        self.view = view
    }
    
    internal func createStep(userId: String!, directionId: String!, parameters: Dictionary<String, AnyObject>) {
        model.createStep(userNick: userId, directionId: directionId, parameters: parameters,
        success: { step in
            self.view.successCreation(step: step)
        },
        failure: { error in
            self.view.failureCreation(error: error)
        })
    }
}
