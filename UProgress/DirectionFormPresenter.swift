//
//  DirectionFormPresenter.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 27.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class DirectionFormPresenter: DirectionFormPresenterProtocol {
    private var model: DirectionModelProtocol!
    private var view: DirectionFormProtocol!
    
    init(model: DirectionModelProtocol, view: DirectionFormProtocol) {
        self.model = model
        self.view = view
    }
    
    internal func createDirection(userNick: String!, parameters: Dictionary<String, Any>) {
        view.startLoader()
        model.createDirection(userNick: userNick, parameters: parameters,
        success: { direction in
            self.view.stopLoader()
            self.view.successCreation(direction: direction)
        },
        failure: { error in
            self.view.stopLoader()
            self.view.failedCreation(error: error)
        })
    }
}
