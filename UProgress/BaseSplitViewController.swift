//
//  MySplitViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 05.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class BaseSplitViewController: UISplitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = AuthorizationService.sharedInstance.currentUser
        if (user != nil) {
            let detailViewController = CommonFunctions.fromStoryboard(name: "DirectionsStoryboard", identifier: "DirectionsListViewController") as! DirectionsListViewController
//            navigationController.setUser(user: user!)
            let navCtrl = UINavigationController(rootViewController: detailViewController)
            self.viewControllers[1] = navCtrl
            self.preferredDisplayMode = .allVisible
        }
    }
}
