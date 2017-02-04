//
//  LaunchPresenter.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 05.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class LaunchPresenter: LaunchPresenterProtocol {
    private var model: AuthorizationManagerProtocol!
    private var view: LaunchViewProtocol!
    
    init(model: AuthorizationManagerProtocol!, view: LaunchViewProtocol) {
        self.model = model
        self.view = view
    }
    
    internal func currentUser() {
        view.startLoader()
        model.currentUser(
        success: { user in
            self.view.stopLoader()
            self.view.successCurrentUserReceived()
        },
        failure: { error in
            self.view.stopLoader()
            self.view.failedCurrentUserReceived(error: error)
        })
    }
}
