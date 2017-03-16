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
    var selectedStep: Step!
    private var directionDetailView: DirectionDetailView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setColoredTitle(title: NSLocalizedString("direction_detail_title", comment: ""))
        directionDetailView = DirectionDetailView(table: tableView,
                                                  direction: direction,
                                                  viewController: self, view: view )
    }
    
    internal func selectStepItem(step: Step) {
    
    }
    
    internal func createStep() {
        performSegue(withIdentifier: "modal", sender: self)
    }
    
    internal func showStepDescription(step: Step) {
        selectedStep = step
        performSegue(withIdentifier: "step_detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "modal") {
             let viewController = segue.destination as! StepFormViewController
             viewController.mainView = self
             viewController.direction = direction
        }
        
        if (segue.identifier == "step_detail") {
            let viewController = segue.destination as! StepDetailViewController
            viewController.step = selectedStep
            selectedStep = nil
        }
    }
    
    internal func successOperation(step: Step) {
        directionDetailView.addStep(step: step)
    }
    
    internal func failedOperation(error: ServerError) {
    
    }
}
