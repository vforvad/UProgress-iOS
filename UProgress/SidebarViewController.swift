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
        
    }
}
