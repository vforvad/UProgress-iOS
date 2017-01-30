//
//  DirectionListPresenterImpl.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class DirectionListPresenterImpl: DirectionsListPresenter {
    private var model: DirectionModelProtocol!
    private var view: DirectionViewProtocol
    
    init(model: DirectionModelProtocol, view: DirectionViewProtocol) {
        self.model = model
        self.view = view
    }
    
    internal func loadDirections(userNick: String!, pageNumber: Int!) {
        model.loadDirectionsList(userNick: userNick, pageNumber: pageNumber,
        success: { directions in
            self.view.successDirectionsLoad(directions: directions)
        },
        failure: { error in
            self.view.failedDirectionsLoad(error: error)
        })
    }
}
