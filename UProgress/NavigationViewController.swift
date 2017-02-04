//
//  NavigationViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 30.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import SideMenuController

class NavigationViewController: SideMenuController {
    static var isMainControllerVisible = true
    
    required init?(coder aDecoder: NSCoder) {
        SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "menu")
        SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
        SideMenuController.preferences.drawing.sidePanelWidth = 300
        SideMenuController.preferences.drawing.centerPanelShadow = true
        SideMenuController.preferences.animating.statusBarBehaviour = .showUnderlay
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue(withIdentifier: "embedInitialCenterController", sender: nil)
        performSegue(withIdentifier: "embedSideController", sender: nil)
    }
    
    open override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if NavigationViewController.isMainControllerVisible {
            return super.gestureRecognizer(gestureRecognizer, shouldReceive: touch)
        } else {
            return false
        }
    }
}
