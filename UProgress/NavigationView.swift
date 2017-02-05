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
    private let signedInItems = [
        ["title": "Directions", "segue": "directions"]
    ]
    private var unsignedItems = [
        ["title": "Sign in", "segue": "sign_in"],
        ["title": "Sign up", "segue": "sign_up"]
    ]
    private var tableView: UITableView!
    private var viewController: NavigationViewProtocol!
    
    init(viewController: NavigationViewProtocol!, table: UITableView!) {
        super.init()
        currentUser = AuthorizationService.sharedInstance.currentUser
        items = currentUser == nil ? unsignedItems : signedInItems
        self.viewController = viewController
        self.tableView = table
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: cellIdentificator)
        cell.textLabel?.text = items[indexPath.row]["title"]
        return cell
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func setUser(user: User!) {
        currentUser = user
        items = signedInItems
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController.onItemSelect(segueName: items[indexPath.row]["segue"])
    }
}
