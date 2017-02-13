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
    @IBOutlet weak var statusSwitcher: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    public func setData(step: Step!) {
        self.step = step
        self.titleLabel.text = self.step.title
        if let doneStep = self.step.isDone {
            self.statusSwitcher.setOn(true, animated: false)
        }
        else {
            self.statusSwitcher.setOn(false, animated: false)
        }
    }
}
