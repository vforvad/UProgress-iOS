//
//  DirectionDetailView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 09.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import Toaster

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
    
    init(table: UITableView!, direction: Direction!, viewController: BaseViewController ) {
        super.init()
        self.viewController = viewController 
        actions = viewController as! DirectionViewActionsProtocol
        self.direction = direction
        self.tableView = table
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupUIRefreshController()
        
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let myBtn: UIButton = UIButton()
        myBtn.setImage(UIImage(named: "add_icon"), for: .normal)
        myBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: navButtonSize, height: navButtonSize))
        myBtn.addTarget(self, action: #selector(createStep), for: .touchUpInside)
        viewController.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: myBtn)
//            UIBarButtonItem(image: UIImage(image: "menu"), style: .plain, target: self, action: #selector(createStep)),
//            UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(removeDirection),
//                            image: UIImage(image: "menu"))
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StepTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.setData(step: steps[indexPath.row], viewController: self)
        return cell as UITableViewCell
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
    
    // MARK: Refresh Control
    func setupUIRefreshController() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("pull_to_refresh", comment: ""))
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
        
    }
}
