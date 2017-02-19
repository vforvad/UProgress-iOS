//
//  ProfileViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: BaseViewController {
    var user: User!
    var profileView: ProfileView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView = ProfileView(user: user, table: tableView)
    }
}
