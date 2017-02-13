//
//  DirectionsDetailViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class DirectionsDetailViewController: BaseViewController, DirectionViewActionsProtocol, DirectionsPopupProtocol {
    var direction: Direction!
    private var directionDetailView: DirectionDetailView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        directionDetailView = DirectionDetailView(table: tableView, direction: direction, viewController: self )
    }
    
    internal func selectStepItem(step: Step) {
    
    }
    
    internal func createStep() {
        performSegue(withIdentifier: "modal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "modal") {
             var viewController = segue.destination as! StepFormViewController
             viewController.mainView = self
             viewController.direction = direction
        }
    }
    
    internal func successOperation(step: Step) {
        directionDetailView.addStep(step: step)
    }
    
    internal func failedOperation(error: ServerError) {
    
    }
    
}
