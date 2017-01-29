//
//  DirectionsListView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class DirectionsListView: NSObject, UITableViewDataSource, UITableViewDelegate {
    var cellIdentifier = "cellId"
    var itemsList:[Direction]! = []
    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var viewController: DirectionsListViewProtocol!
    
    init(viewController: DirectionsListViewProtocol!, table: UITableView!, searchBar: UISearchBar!) {
        super.init()
        self.viewController = viewController
        self.tableView = table
        self.searchBar = searchBar
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellId")
        cell.textLabel?.text = itemsList[indexPath.row].title
        return cell
    }


    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    public func updateData(directions: [Direction]!) {
        self.itemsList = directions
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController.clickOnItem(direction: itemsList[indexPath.row], indexPath: indexPath)
    }
}
