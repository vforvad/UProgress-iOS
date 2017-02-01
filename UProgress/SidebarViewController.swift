//
//  SidebarViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 30.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class SidebarViewController: BaseViewController, NavigationViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    private var navigationView: NavigationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView = NavigationView(viewController: self, table: tableView)
        
    }
    
    internal func onItemSelect(segueName: String!) {
        if CommonFunctions.DeviceData.isIphone() {
            segueForNavigationController(identifier: segueName)
        }
        else {
            self.performSegue(withIdentifier: segueName, sender: self)
        }
    }
    
    //MARK: Segue Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navVC = segue.destination as! UINavigationController
        
        if (segue.identifier == "directions") {
            _ = navVC.viewControllers.first as! DirectionsListViewController
        }
        if (segue.identifier == "sign_in") {
            let tableVC = navVC.viewControllers.first as! AuthorizationsViewController
            tableVC.signIn = true
        }
        
        if (segue.identifier == "sign_up") {
            let tableVC = navVC.viewControllers.first as! AuthorizationsViewController
            tableVC.signIn = false
        }
    }
    
    private func segueForNavigationController(identifier: String!) {
        var viewController: UIViewController!
        var cacheIdentifier = identifier
        
        switch identifier {
        case "directions":
            viewController = super.fromStoryboard(identifier: "DirectionsListViewController")
        case "sign_in":
            var authViewController = super.fromStoryboard(name: "AuthorizationStoryboard", identifier: "AuthorizationViewController") as! AuthorizationsViewController
            authViewController.signIn = true
            viewController = authViewController as! UIViewController
        case "sign_up":
            var authViewController = super.fromStoryboard(name: "AuthorizationStoryboard", identifier: "AuthorizationViewController") as! AuthorizationsViewController
            authViewController.signIn = false
            viewController = authViewController as! UIViewController
        default:
            viewController = super.fromStoryboard(identifier: "DirectionsListViewController")
        }
        
        if let controller = sideMenuController?.viewController(forCacheIdentifier: cacheIdentifier!) {
            sideMenuController?.embed(centerViewController: controller)
        }
        else {
            sideMenuController?.embed(centerViewController: UINavigationController(rootViewController: viewController), cacheIdentifier: cacheIdentifier)
        }
    }
}
