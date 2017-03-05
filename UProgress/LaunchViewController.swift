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
    let runLauncher = Bundle.main.infoDictionary!["RESET_LAUNCH_VIEW"] as? Bool
    let envValue = (ProcessInfo.processInfo.environment["RESET_LAUNCH_VIEW"] != nil) as Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = AuthorizationManager()
        let presenter = LaunchPresenter(model: model, view: self)
        NavigationViewController.isMainControllerVisible = false
        self.navigationController?.isNavigationBarHidden = true
        let dic = ProcessInfo.processInfo.environment
        if !envValue {
            presenter.currentUser()
        }
    }
    
    internal func startLoader() {
        
    }
    
    internal func stopLoader() {
        NavigationViewController.isMainControllerVisible = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    internal func successCurrentUserReceived() {
        if CommonFunctions.DeviceData.isIphone() {
            var viewController = CommonFunctions.fromStoryboard(name: "DirectionsStoryboard", identifier: "DirectionsListViewController")
            sideMenuController?.embed(centerViewController: UINavigationController(rootViewController: viewController))
        }
        else {
            let storyBoard : UIStoryboard = UIStoryboard(name: "iPad", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "iPadBaseViewController") as! UISplitViewController
            self.present(nextViewController, animated:true, completion:nil)
        }
    }
    
    internal func failedCurrentUserReceived(error: ServerError) {
        var viewController = CommonFunctions.fromStoryboard(name: "AuthorizationStoryboard", identifier: "AuthorizationViewController") as! AuthorizationsViewController
        viewController.signIn = true
        
        if CommonFunctions.DeviceData.isIPad() {
            let storyBoard : UIStoryboard = UIStoryboard(name: "iPad", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "iPadBaseViewController") as! UISplitViewController
            self.present(nextViewController, animated:true, completion:nil)
            let navCtrl = UINavigationController(rootViewController: viewController)
            splitViewController?.viewControllers[1] = navCtrl
        }
        else {
            sideMenuController?.embed(centerViewController: UINavigationController(rootViewController: viewController))
        }
    }
}
