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
        model.loadDirectionsList(userNick: userNick, pageNumber: pageNumber)
            .responseArray(keyPath: "directions") { (response: DataResponse<[Direction]>) in
                switch(response.result) {
                case .success(let value):
                    self.view.successDirectionsLoad(directions: value)
                case .failure(let errorValue):
                    self.view.failedDirectionsLoad(error: errorValue as NSError)
                }
        }
    }
}
