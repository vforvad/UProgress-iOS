//
//  AuthorizationPresenter.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation


class AuthorizationPresenter: AuthorizationPresenterProtocol {

    private var model: AuthorizationManagerProtocol!
    private var view: AuthorizationViewProtocol!
    
    init(model: AuthorizationManagerProtocol, view: AuthorizationViewProtocol) {
        self.model = model
        self.view = view
    }
    
    internal func signIn(parameters: Dictionary<String, AnyObject>) {
        self.view.startLoader()
        model.signIn(signInParameters: parameters,
        success: { user in
            self.view.stopLoader()
            self.view.successSignIn(currentUser: user)
        },
        failure: { error in
            self.view.stopLoader()
            self.view.failedSignIn(error: error)
        })
    }
    
    internal func signUp(parameters: Dictionary<String, AnyObject>) {
        self.view.startLoader()
        model.signUp(signUpParameters: parameters,
        success: { user in
            self.view.stopLoader()
            self.view.successSignIn(currentUser: user)            
        },
        failure: { error in
            self.view.stopLoader()
            self.view.failedSignUp(error: error)
        })
    }
    
    internal func restorePassword(parameters: Dictionary<String, AnyObject>) {
        self.view.startLoader()
        model.restorePassword(restorePassword: parameters,
                     success: { token in
                        self.view.stopLoader()
                        self.view.successRestore(token: token)
        },
                     failure: { error in
                        self.view.stopLoader()
                        self.view.failedRestore(error: error)
        })
    }
    
    internal func resetPassword(parameters: Dictionary<String, AnyObject>) {
        self.view.startLoader()
        model.resetPassword(resetPasswordParams: parameters,
                              success: { message in
                                self.view.stopLoader()
                                self.view.successReset(message: message)
        },
                              failure: { error in
                                self.view.stopLoader()
                                self.view.failedReset(errors: error)
        })
    }
}
