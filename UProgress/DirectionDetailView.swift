//
//  DirectionDetailView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 09.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class DirectionDetailView: NSObject, DirectionsDetailViewProtocol, UITableViewDelegate,
UITableViewDataSource {
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
    
    init(table: UITableView!, direction: Direction!, viewController: BaseViewController ) {
        super.init()
        self.viewController = viewController as! BaseViewController
        actions = viewController as! DirectionViewActionsProtocol
        self.direction = direction
        self.tableView = table
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setupUIRefreshController()
        var myBtn: UIButton = UIButton()
        myBtn.setImage(UIImage(named: "menu"), for: .normal)
        myBtn.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: navButtonSize, height: navButtonSize))
        myBtn.addTarget(self, action: #selector(createStep), for: .touchUpInside)
        viewController.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: myBtn)
//            UIBarButtonItem(image: UIImage(image: "menu"), style: .plain, target: self, action: #selector(createStep)),
//            UIBarButtonItem(title: "Remove", style: .plain, target: self, action: #selector(removeDirection),
//                            image: UIImage(image: "menu"))
        ]
        
        let model = DirectionDetailManager()
        let directionId: String = String(self.direction.id)
        presenter = DirectionsDetailPresenter(model: model, view: self)
        presenter.loadDirection(userNick: "vforvad", directionId: directionId)
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
    
    // MARK: Refresh Control
    func setupUIRefreshController() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("pull_to_refresh", comment: ""))
        //        refreshControl.addTarget(self, action: #selector(DirectionsListView.reloadList), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    public func addStep(step: Step!) {
        steps.insert(step, at: 0)
        tableView.reloadData()
    }
}
