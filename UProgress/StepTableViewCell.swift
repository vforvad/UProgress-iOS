//
//  StepTableViewCell.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 13.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class StepTableViewCell: UITableViewCell {
    private var step: Step!
    private var viewController: StepCellProtocol!
    @IBOutlet weak var statusSwitcher: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    public func setData(step: Step!, viewController: StepCellProtocol!) {
        self.step = step
        self.viewController = viewController
        self.titleLabel.text = self.step.title
        if let doneStep = self.step.isDone {
            if doneStep {
                self.statusSwitcher.setOn(true, animated: false)
            }
            else {
                self.statusSwitcher.setOn(false, animated: false)
            }
            
        }
        else {
            self.statusSwitcher.setOn(false, animated: false)
        }
    }
    @IBAction func toggleStatus(_ sender: UISwitch) {
        var status = sender.isOn
        viewController.toggleSwitcher(step: step, value: status)
    }
}
