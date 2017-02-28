//
//  ViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 28.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//
import Foundation
import UIKit
import MBProgressHUD

class DirectionsListViewController: BaseViewController, DirectionViewProtocol, DirectionsListViewProtocol,
DirectionPopupActions {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var selectedDirection: Direction!
    var itemsList:[Direction]! = []
    private let userNick = "vforvad"
    private let manager = DirectionManager()
    private var presenter: DirectionListPresenterImpl!
    private var viewInstance: DirectionsListView!
    public var refreshControl: UIRefreshControl!
    var actInd : UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInstance = DirectionsListView(viewController: self, table: tableView, searchBar: searchBar)
        presenter = DirectionListPresenterImpl(model: manager, view: self)
        presenter.loadDirections(userNick: userNick)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func successDirectionsLoad(directions: [Direction]!) {
        viewInstance.updateData(directions: directions)
    }
    
    internal func successLoadMoreDirections(directions: [Direction]!) {
        viewInstance.addDirections(directions: directions)
    }
    
    internal func stopLoader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    internal func startLoader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    internal func failedDirectionsLoad(error: NSError) {
        
    }
    
    internal func clickOnItem(direction: Direction, indexPath: IndexPath!) {
        selectedDirection = direction
        performSegue(withIdentifier: "detail", sender: self)
    }
    
    internal func refreshTriggered() {
        presenter.reloadDirectionsList(userNick: userNick)
    }
    
    internal func infiniteScrollTriggered() {
        presenter.loadMoreDirections(userNick: userNick)
    }
    
    internal func startRefresh() {
        viewInstance.refreshControl.beginRefreshing()
    }
    
    internal func stopRefresh() {
        viewInstance.refreshControl.endRefreshing()
    }
    
    internal func stopInfiniteScroll() {
        viewInstance.stopInfiniteScroll()
    }
    
    internal func createDirection() {
        performSegue(withIdentifier: "directions_form", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            let detailViewController = segue.destination as! DirectionsDetailViewController
            detailViewController.direction = selectedDirection
            detailViewController.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            detailViewController.navigationItem.leftItemsSupplementBackButton = true
        }
        if segue.identifier == "directions_form" {
            let formViewController = segue.destination as! DirectionsFormViewController
            formViewController.actions = self
        }
        selectedDirection = nil
    }
    
    internal func successOperation(direction: Direction) {
        viewInstance.addDirection(direction: direction)
    }
    
    internal func failedOperation(error: ServerError) {
    
    }
}

