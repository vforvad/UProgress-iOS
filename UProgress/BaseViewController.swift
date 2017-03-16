//
//  ApplicationViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 30.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import UIColor_Hex_Swift

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CommonFunctions.DeviceData.isIPad() {
            self.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
            self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        }
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.signedOut(user:)), name: NSNotification.Name(rawValue: "signOut"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let color = UIColor("#55BA52")
        self.navigationController?.navigationBar.barTintColor = color
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func signedOut(user: Notification) {
        if CommonFunctions.DeviceData.isIphone() {
            let viewController = CommonFunctions.fromStoryboard(name: "AuthorizationStoryboard", identifier: "AuthorizationViewController") as! AuthorizationsViewController
            viewController.signIn = true
            sideMenuController?.embed(centerViewController: UINavigationController(rootViewController: viewController))
        }
        else {
            let detailViewController = CommonFunctions.fromStoryboard(name: "AuthorizationStoryboard", identifier: "AuthorizationViewController") as! AuthorizationsViewController
            detailViewController.signIn = true
            let navCtrl = UINavigationController(rootViewController: detailViewController)
            splitViewController?.viewControllers[1] = navCtrl
        }
    }
    
    func setColoredTitle(title: String) {
        self.title = title
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleDict as! [String : Any]

    }
}
