//
//  DirectionsDetailViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class DirectionsDetailViewController: UIViewController, DirectionsDetailViewProtocol, UITableViewDelegate,
UITableViewDataSource {
    var steps: [Step]! = []
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
        steps = direction.steps
        tableView.reloadData()
    }
    
    internal func failedDirectionLoad(error: NSError) {
    
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UITableViewCell
        if steps[indexPath.row] != nil {
            cell.textLabel?.text = steps[indexPath.row].title
        }
//        cell.textLabel?.text = direction.steps?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Section \(section)"
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView(frame :CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 300, height: 300)))
        vw.backgroundColor = UIColor.red
        
        return vw
    }
}
