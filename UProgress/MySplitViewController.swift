//
//  MySplitViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 05.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class MySplitViewController: UISplitViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var user = AuthorizationService.sharedInstance.currentUser
        if (user != nil) {
//            let navigationController = self.storyboard!.instantiateViewController(withIdentifier: "SidebarViewController") as! SidebarViewController
            let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "DirectionsListViewController") as! DirectionsListViewController
//            navigationController.setUser(user: user!)
            let navCtrl = UINavigationController(rootViewController: detailViewController)
            self.viewControllers[1] = navCtrl
        }
    }
}
