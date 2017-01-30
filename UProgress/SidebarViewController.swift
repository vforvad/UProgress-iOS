//
//  SidebarViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 30.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class SidebarViewController: UIViewController, NavigationViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    private var navigationView: NavigationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationView = NavigationView(viewController: self, table: tableView)
        
    }
    
    internal func onItemSelect(segueName: String!) {
        if CommonFunctions.DeviceData.isIphone() {
            sideMenuController?.performSegue(withIdentifier: segueName, sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "directions", sender: self)
        }
    }
    
    //MARK: Segue Navigation
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navVC = segue.destination as! UINavigationController
        
        if (segue.identifier == "directions") {
            _ = navVC.viewControllers.first as! DirectionsListViewController
        }
    }
}
