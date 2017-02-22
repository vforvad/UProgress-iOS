//
//  ProfileView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 19.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class ProfileView: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var cellIdentifier = "profileItem"
    private var user: User!
    private var tableView: UITableView!
    private var profileItems = [Dictionary<String, String>]()
    private var profileHeader: ProfileHeader!
    private let navButtonSize = 30
    private var viewController: BaseViewController!
    private var actions: ProfileViewActionsProtocol!
    
    init(user: User!, table: UITableView!, viewController: BaseViewController) {
        super.init()
        self.user = user
        self.tableView = table
        self.viewController = viewController
        self.actions = viewController as! ProfileViewActionsProtocol
        
        
        self.tableView.estimatedRowHeight = 300
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.profileItems = user.attributesDictionary()
        
        tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        let myBtn: UIButton = UIButton()
        myBtn.setImage(UIImage(named: "settings_icon"), for: .normal)
        myBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: navButtonSize, height: navButtonSize))
        myBtn.addTarget(self, action: #selector(createStep), for: .touchUpInside)
        viewController.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: myBtn)
            //            UIBarButtonItem(image: UIImage(image: "menu"), style: .plain, target: self, action: #selector(createStep)),
            //            UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(removeDirection),
            //                            image: UIImage(image: "menu"))
        ]
        
    }
    
    func createStep() {
        actions.editUser()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        cell.setData(list: profileItems[indexPath.row])
//        cell.textLabel?.text = profileItems[indexPath.row]["value"]
//        cell.detailTextLabel?.text = profileItems[indexPath.row]["title"]
        return cell as! UITableViewCell
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItems.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        profileHeader = ProfileHeader.instanceFromNib() as! ProfileHeader
        profileHeader.setData(user: user)
        return profileHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }
}
