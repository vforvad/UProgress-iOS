//
//  LaunchViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 05.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import SideMenuController

class LaunchViewController: UIViewController {
    var isMainControllerVisible = false
    override func viewDidLoad() {
        super.viewDidLoad()
        NavigationViewController.isMainControllerVisible = false
        self.view.isUserInteractionEnabled = false
        self.navigationController?.isNavigationBarHidden = true
        SideMenuController.preferences.interaction.swipingEnabled = false
    }
}
