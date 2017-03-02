//
//  MySplitViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 05.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class BaseSplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        let user = AuthorizationService.sharedInstance.currentUser
        var navCtrl: UINavigationController!
        
        if (user != nil) {
            let detailViewController = CommonFunctions.fromStoryboard(name: "DirectionsStoryboard", identifier: "DirectionsListViewController") as! DirectionsListViewController
            navCtrl = UINavigationController(rootViewController: detailViewController)
            
        }
        else {
            let authVC = CommonFunctions.fromStoryboard(name: "AuthorizationStoryboard", identifier: "AuthorizationViewController") as! AuthorizationsViewController
            authVC.signIn = true
            navCtrl = UINavigationController(rootViewController: authVC)
        }
        
        self.viewControllers[1] = navCtrl
        self.preferredDisplayMode = .allVisible

    }
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool{
        return true
    }
}
