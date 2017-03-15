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
        self.view.backgroundColor = UIColor("#B1E8AE")
//        navigationController?.setNavigationBarHidden(false, animated: true)
//        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.isTranslucent = true
//        let profileHeader = ProfileHeader.instanceFromNib() as! ProfileHeader
//        profileHeader.setData(user: user)
//        navigationController?.navigationBar.topItem?.titleView = profileHeader
//        let height: CGFloat = 300 //whatever height you want
//        let bounds = self.navigationController!.navigationBar.bounds
//        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
        
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
