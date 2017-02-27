//
//  ProfilePresenter.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 23.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class ProfilePresenter: ProfilePresenterProtocol {
    private var model: ProfileManagerProtocol!
    private var view: ProfileViewProtocol!
    
    init(model: ProfileManagerProtocol!, view: ProfileViewProtocol!) {
        self.model = model
        self.view = view
    }
    
    internal func updateProfile(userId: String!, parameters: Dictionary<String, AnyObject>) {
        model.updateProfile(userId: userId, profileParameters: parameters,
        success: { user in
            self.view.successUpdate(user: user)
        },
        failure: { error in
            self.view.failedUpdate(error: error)
        })
    }
}
