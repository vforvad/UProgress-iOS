//
//  DirectionsDetailPresenter.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class DirectionsDetailPresenter: DirectionsDetailPresenterProtocol {
    private var model: DirectionModelProtocol!
    private var view: DirectionsDetailViewProtocol!
    
    init(model: DirectionModelProtocol, view: DirectionsDetailViewProtocol) {
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
}
