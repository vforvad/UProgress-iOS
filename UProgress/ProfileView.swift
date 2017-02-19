//
//  ProfileView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 19.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class ProfileView: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var cellIdentifier = "profileItem"
    private var user: User!
    private var tableView: UITableView!
    private var profileItems = [Dictionary<String, String>]()
    private var profileHeader: ProfileHeader!
    
    init(user: User!, table: UITableView!) {
        super.init()
        self.user = user
        self.tableView = table
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) 
        return cell as UITableViewCell
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileItems.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
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
