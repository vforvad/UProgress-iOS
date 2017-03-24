//
//  ProfileViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: BaseViewController, ProfileViewActionsProtocol, ProfilePopupProtocol {
    var user: User!
    var profileView: ProfileView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setColoredTitle(title: NSLocalizedString("profile_title", comment: ""))
        self.view.backgroundColor = UIColor("#B1E8AE")        
        profileView = ProfileView(user: user, table: tableView, viewController: self)
    }
    
    func editUser() {
        performSegue(withIdentifier: "profile_popup", sender: self)
    }
    
    internal func successUserUpdate(user: User!) {
        profileView.updateUser(user: user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile_popup" {
            let viewController = segue.destination as! ProfileFormViewController
            viewController.actions = self
        }
    }
}
