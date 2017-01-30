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
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navVC = segue.destination as! UINavigationController
        
        if (segue.identifier == "directions") {
            _ = navVC.viewControllers.first as! DirectionsListViewController
        }
    }
    
    private func segueForNavigationController(identifier: String!) {
        var viewController: UIViewController!
        var cacheIdentifier = identifier
        
        switch identifier {
        case "directions":
            viewController = super.fromStoryboard(identifier: "DirectionsListViewController")
        case "sign_in":
            viewController = super.fromStoryboard(identifier: "AuthorizationViewController")
        case "sign_up":
            viewController = super.fromStoryboard(identifier: "AuthorizationViewController")
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
