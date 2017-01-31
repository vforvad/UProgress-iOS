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
    private var pageNumber = 1
    
    init(model: DirectionModelProtocol, view: DirectionViewProtocol) {
        self.model = model
        self.view = view
    }
    
    internal func loadDirections(userNick: String!) {
        view.startLoader()
        model.loadDirectionsList(userNick: userNick, pageNumber: pageNumber,
        success: { directions in
            self.view.stopLoader()
            self.view.successDirectionsLoad(directions: directions)
        },
        failure: { error in
            self.view.stopLoader()
            self.view.failedDirectionsLoad(error: error)
        })
    }
    
    internal func reloadDirectionsList(userNick: String!) {
        view.startRefresh()
        model.loadDirectionsList(userNick: userNick, pageNumber: 1,
        success: { directions in
            self.view.stopRefresh()
            self.view.successDirectionsLoad(directions: directions)
        },
        failure: { error in
            self.view.stopRefresh()
            self.view.failedDirectionsLoad(error: error)
        })
    }
    
    internal func loadMoreDirections(userNick: String!) {
        pageNumber += 1
        model.loadDirectionsList(userNick: userNick, pageNumber: pageNumber,
        success: { directions in
            self.view.stopInfiniteScroll()
            self.view.successLoadMoreDirections(directions: directions)
        },
        failure: { error in
            self.view.stopInfiniteScroll()
            self.view.failedDirectionsLoad(error: error)
        })
    }
}
