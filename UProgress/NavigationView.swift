//
//  NavigationView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 30.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class NavigationView: NSObject, UITableViewDelegate, UITableViewDataSource {
    private let cellIdentificator = "navigationCellId"
    private var currentUser: User!
    private var items: [Dictionary<String, String>] = []
    private var signedInItems = [
        ["title": NSLocalizedString("sidebar_directions", comment: ""), "segue": "directions", "icon": "directions"]
    ]
    private var unsignedItems = [
        ["title": NSLocalizedString("sidebar_sign_in", comment: ""), "segue": "sign_in", "icon": "sign_in"],
        ["title": NSLocalizedString("sidebar_sign_up", comment: ""), "segue": "sign_up", "icon": "sign_up"]
    ]
    private var tableView: UITableView!
    private var viewController: NavigationViewProtocol!
    
    init(viewController: NavigationViewProtocol!, table: UITableView!) {
        super.init()
        currentUser = AuthorizationService.sharedInstance.currentUser
        if currentUser != nil {
            signedInItems.insert(["segue": "profile"], at: 0)
        }
        items = currentUser == nil ? unsignedItems : signedInItems
        self.viewController = viewController
        self.tableView = table
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: "ProfileViewCell", bundle: nil), forCellReuseIdentifier: "profileCell")
        tableView.register(UINib(nibName: "DefaultNavigationCell", bundle: nil), forCellReuseIdentifier: cellIdentificator)
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell!
        if isProfileCell(item: items[indexPath.row]) {
            let profileCell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileViewCell
            profileCell.setData(user: currentUser)
            cell = profileCell
        }
        else {
            var navCell = tableView.dequeueReusableCell(withIdentifier: cellIdentificator, for: indexPath) as! DefaultNavigationCell
            navCell.textView.text = items[indexPath.row]["title"]
            let iconName = items[indexPath.row]["icon"]
            navCell.iconView.image = UIImage(named: iconName!)
            cell = navCell
        }
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func setUser(user: User!) {
        currentUser = user
        signedInItems.insert(["segue": "profile"], at: 0)
        items = signedInItems
        tableView.reloadData()
    }
    
    public func updateUser(user: User!) {
        currentUser = user
        tableView.reloadData()
    }
    
    public func userSignedOut() {
        currentUser = nil
        signedInItems.remove(at: 0)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isProfileCell(item: items[indexPath.row]) {
            return 80
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController.onItemSelect(segueName: items[indexPath.row]["segue"])
    }
    
    private func isProfileCell(item: Dictionary<String, String>) -> Bool {
        return item["segue"] == "profile"
    }
}
