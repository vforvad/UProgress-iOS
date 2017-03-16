//
//  DirectionsListView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import UIScrollView_InfiniteScroll

class DirectionsListView: NSObject, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var searchActive : Bool = false
    var cellIdentifier = "cellId"
    var itemsList:[Direction]! = []
    var filtered:[Direction] = []
    public var refreshControl: UIRefreshControl!
    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var viewController: DirectionsListViewProtocol!
    private var realViewController: BaseViewController!
    
    init(viewController: BaseViewController!, table: UITableView!, searchBar: UISearchBar!) {
        super.init()
        self.viewController = viewController as! DirectionsListViewProtocol
        self.realViewController = viewController
        self.tableView = table
        self.searchBar = searchBar
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = false
        self.searchBar.placeholder = NSLocalizedString("search", comment: "")
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor("#f6f7f8")
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        tableView.register(UINib(nibName: "DirectionsListCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        realViewController.navigationItem.rightBarButtonItems = [
            CommonFunctions.makeBarButton(withIcon: "add_icon", action: #selector(createDirection(sender:)), target: self)
        ]
        
        setupUIRefreshController()
        setupInfinteScrolling()
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! DirectionsListCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        var item: Direction!
        if (searchActive) {
            item = filtered[indexPath.row]
        }
        else {
            item = itemsList[indexPath.row]
        }
        cell.setData(direction: item)
        return cell as UITableViewCell
    }
    
    public func updateData(directions: [Direction]!) {
        self.itemsList = directions
        self.tableView.reloadData()
    }
    
    public func addDirections(directions: [Direction]!) {
        self.itemsList.append(contentsOf: directions)
        self.tableView.reloadData()
    }
    
    public func stopInfiniteScroll() {
        tableView.finishInfiniteScroll()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if itemsList.count > 0 {
            tableView.backgroundView = nil
            return 1
        }
        else {
            let view = EmptyTableView.instanceFromNib() as! EmptyTableView
            view.emptyLabel.text = NSLocalizedString("directions_empty", comment: "")
            tableView.backgroundView  = view
            return 0
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchActive) {
            return filtered.count
        }
        return itemsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewController.clickOnItem(direction: itemsList[indexPath.row], indexPath: indexPath)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.text = ""
        searchActive = false;
        self.searchBar.showsCancelButton = false
        self.searchBar.reloadInputViews()
        self.searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = itemsList.filter({ (direction) -> Bool in
            let tmp: NSString = direction.title as NSString
            let range = tmp.range(of: searchText, options: .caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    
    func reloadList() {
        viewController.refreshTriggered()
    }
    
    
    // MARK: Refresh Control
    func setupUIRefreshController() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("pull_to_refresh", comment: ""))
        refreshControl.addTarget(self, action: #selector(DirectionsListView.reloadList), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    // MARK: Infinite scroll
    func setupInfinteScrolling() {
        tableView.infiniteScrollIndicatorStyle = .gray
        self.tableView.addInfiniteScroll { (scrollView) -> Void in
            self.viewController.infiniteScrollTriggered()
        }
    }
    
    func createDirection(sender: UIBarButtonItem) {
       viewController.createDirection()
    }
    
    func addDirection(direction: Direction) {
        itemsList.insert(direction, at: 0)
        self.tableView.reloadData()
    }

}
