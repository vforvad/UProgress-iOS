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
    var direction: Direction!
    var steps: [Step]! = []
    var directionDetailView: DirectionDetailInfoView!
    let cellIdentifier = "stepId"
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
        self.direction = direction
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        directionDetailView = DirectionDetailInfoView.instanceFromNib() as! DirectionDetailInfoView
        if self.direction != nil {
            directionDetailView.setDirection(direction: self.direction)
        }
//        vw.backgroundColor = UIColor.red
        
        return directionDetailView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.direction != nil && directionDetailView != nil {
            var height = directionDetailView.getHeight()
            return height
        }
        return 200
    }
}
