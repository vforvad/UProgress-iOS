//
//  DirectionDetailView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 09.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Toaster
import MBProgressHUD
import UIKit
import CDAlertView

class DirectionDetailView: NSObject, DirectionsDetailViewProtocol, UITableViewDelegate,
UITableViewDataSource, StepCellProtocol {
    var direction: Direction!
    var actions: DirectionViewActionsProtocol!
    var viewController: BaseViewController!
    var steps: [Step]! = []
    var directionDetailView: DirectionDetailInfoView!
    let cellIdentifier = "stepId"
    var presenter: DirectionsDetailPresenter!
    public var refreshControl: UIRefreshControl!
    private var tableView: UITableView!
    private let navButtonSize = 30
    private var user = AuthorizationService.sharedInstance.currentUser
    private var directionId: String!
    private var parentView: UIView!
    private var selectedCellIndexPath: IndexPath!
    
    init(table: UITableView!, direction: Direction!, viewController: BaseViewController, view: UIView! ) {
        super.init()
        self.viewController = viewController 
        actions = viewController as! DirectionViewActionsProtocol
        self.direction = direction
        self.tableView = table
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.parentView = view
        setupUIRefreshController()
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let myBtn: UIButton = UIButton()
        myBtn.setImage(UIImage(named: "add_icon"), for: .normal)
        myBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: navButtonSize, height: navButtonSize))
        myBtn.addTarget(self, action: #selector(createStep), for: .touchUpInside)
        viewController.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: myBtn)
        ]
        
        tableView.register(UINib(nibName: "StepTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        directionId = String(self.direction.id)
        let model = DirectionDetailManager()
        
        presenter = DirectionsDetailPresenter(model: model, view: self)
        presenter.loadDirection(userNick: user?.nick, directionId: directionId)
    }
    
    func createStep() {
        actions.createStep()
    }
    
    func removeDirection() {
    
    }
    
    internal func startLoader() {
        MBProgressHUD.showAdded(to: parentView, animated: true)
    }
    
    internal func stopLoader() {
        MBProgressHUD.hide(for: parentView, animated: true)
    }
    
    internal func startRefreshing() {
        refreshControl.beginRefreshing()
    }
    
    internal func stopRefreshing() {
        refreshControl.endRefreshing()
    }
    
    internal func successDirectionLoad(direction: Direction!) {
        self.direction = direction
        steps = direction.steps
        tableView.reloadData()
    }
    
    internal func failedDirectionLoad(error: ServerError) {
        switch(error.status!) {
        case 400 ... 499:
            CDAlertView(title: NSLocalizedString("not_found", comment: ""),
                        message: NSLocalizedString("direction_not_found", comment: ""), type: .error).show()
        default:
            CDAlertView(title: NSLocalizedString("error_title", comment: ""),
                        message: NSLocalizedString("server_not_respond", comment: ""), type: .error).show()
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return steps.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StepTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.setData(step: steps[indexPath.row], viewController: self)
        return cell as UITableViewCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .normal, title: NSLocalizedString("delete_step", comment: "")) { action, index in
            self.selectedCellIndexPath = index
            let step = self.steps[index.row]
            self.presenter.deleteStep(userId: self.user?.nick, directionId: self.directionId, stepId: String(step.id))
        }
        delete.backgroundColor = UIColor.red
        return [delete]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        directionDetailView = DirectionDetailInfoView.instanceFromNib() as! DirectionDetailInfoView
        if self.direction != nil {
            directionDetailView.setDirection(direction: self.direction)
        }
        
        return directionDetailView
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.direction != nil && directionDetailView != nil {
            let height = directionDetailView.getHeight()
            return height
        }
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actions.showStepDescription(step: steps[indexPath.row])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if steps.count > 0 {
            tableView.backgroundView = nil
            return 1
        }
        else {
            let view = EmptyTableView.instanceFromNib() as! EmptyTableView
            view.emptyLabel.text = NSLocalizedString("steps_empty", comment: "")
            tableView.backgroundView  = view
            return 1
        }
    }
    
    func reloadList() {
        presenter.refreshDirection(userNick: user?.nick, directionId: directionId)
    }
    
    // MARK: Refresh Control
    func setupUIRefreshController() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("pull_to_refresh", comment: ""))
        refreshControl.addTarget(self, action: #selector(DirectionDetailView.reloadList), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    public func addStep(step: Step!) {
        steps.insert(step, at: 0)
        self.direction = step.direction
        tableView.reloadData()
    }

    
    internal func toggleSwitcher(step: Step!, value: Bool!) {
        let params = ["title": step.title, "description": step.description, "direction_id": self.direction.id, "is_done": value] as [String : Any]
        presenter.updateStep(userId: user?.nick, directionId: directionId, stepId: String(step.id), parameters: params as Dictionary<String, AnyObject>)
    }
    
    internal func successStepUpdate(step: Step!) {
        let index = steps.index(where: { $0.id == step.id })
        steps.remove(at: index!)
        steps.insert(step, at: index!)
        self.direction = step.direction
        tableView.reloadData()
        Toast(text: String.localizedStringWithFormat(NSLocalizedString("steps_update_success", comment: ""), step.title!)).show()
    }
    
    internal func failureStepUpdate(error: ServerError!) {
        Toast(text: NSLocalizedString("steps_update_failed", comment: "")).show()
    }
    
    internal func successStepDelete(step: Step!){
        let index = steps.index(where: { $0.id == step.id })
        steps.remove(at: index!)
        self.direction = step.direction
        self.tableView.deleteRows(at: [selectedCellIndexPath], with: UITableViewRowAnimation.bottom)
        Toast(text: String.localizedStringWithFormat(NSLocalizedString("steps_delete_success", comment: ""), step.title!)).show()
        selectedCellIndexPath = nil
    }
    
    internal func failureStepDelete(error: ServerError!) {
    
    }
}
