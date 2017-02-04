//
//  LaunchViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 05.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import SideMenuController

class LaunchViewController: UIViewController, LaunchViewProtocol {
    var isMainControllerVisible = false
    var presenter: LaunchPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var model = AuthorizationManager()
        var presenter = LaunchPresenter(model: model, view: self)
        NavigationViewController.isMainControllerVisible = false
        self.navigationController?.isNavigationBarHidden = true
        presenter.currentUser()
    }
    
    internal func startLoader() {
        
    }
    
    internal func stopLoader() {
        NavigationViewController.isMainControllerVisible = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    internal func successCurrentUserReceived() {
        var viewController = CommonFunctions.fromStoryboard(identifier: "DirectionsListViewController")
        sideMenuController?.embed(centerViewController: UINavigationController(rootViewController: viewController))
    }
    
    internal func failedCurrentUserReceived(error: ServerError) {
    
    }
}
