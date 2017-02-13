//
//  DirectionsDetailPresenter.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class DirectionsDetailPresenter: DirectionsDetailPresenterProtocol {
    private var model: DirectionDetailManagerProtocol!
    private var view: DirectionsDetailViewProtocol!
    
    init(model: DirectionDetailManagerProtocol, view: DirectionsDetailViewProtocol) {
        self.model = model
        self.view = view
    }
    
    
    func loadDirection(userNick: String!, directionId: String!) {
        model.loadDirection(userNick: userNick, directionId: directionId,
        success: { direction in
            self.view.successDirectionLoad(direction: direction)
        },
        failure: { error in
            self.view.failedDirectionLoad(error: error)
        })
    }
    
    internal func updateStep(userId: String!, directionId: String!, stepId: String!, parameters: Dictionary<String, AnyObject>) {
        view.startLoader()
        model.updateStep(userNick: userId, directionId: directionId, stepId: stepId, parameters: parameters,
                         success: { step in
                            self.view.stopLoader()
                            self.view.successStepUpdate(step: step)
        }, failure: { error in
            self.view.stopLoader()
            self.view.failureStepUpdate(error: error)
        })
    }
}
