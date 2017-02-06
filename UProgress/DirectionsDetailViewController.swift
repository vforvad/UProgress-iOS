//
//  DirectionsDetailViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class DirectionsDetailViewController: UIViewController, DirectionsDetailViewProtocol, UITableViewDelegate,
UITableViewDataSource {
    let cellIdentifier = "stepId"
    var direction: Direction!
    var presenter: DirectionsDetailPresenter!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let model = DirectionManager()
        let directionId: String = String(direction.id)
        presenter = DirectionsDetailPresenter(model: model, view: self)
        presenter.loadDirection(userNick: "vforvad", directionId: directionId)
    }
    
    internal func startLoader() {
    
    }
    
    internal func stopLoader() {
    
    }
    
    internal func successDirectionLoad(direction: Direction!) {
    
    }
    
    internal func failedDirectionLoad(error: NSError) {
    
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UITableViewCell
//        cell.textLabel?.text = direction.steps?[indexPath.row].title
        return cell
    }
}
