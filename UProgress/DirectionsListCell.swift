//
//  DirectionsListCell.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 31.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class DirectionsListCell: UITableViewCell {
    private var direction: Direction!
    @IBOutlet var percentValue: UILabel!
    @IBOutlet var titleValue: UILabel!
    @IBOutlet var updatedAtValue: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        self.cardView.alpha = 1.0
        self.cardView.layer.masksToBounds = false
        self.cardView.layer.cornerRadius = 5

    }
    
    public func setData(direction: Direction!) {
        self.direction = direction
        self.percentValue.text = String(direction.percentsResult)
        self.titleValue.text = direction.title
        self.descriptionLabel.text = direction.description
        self.updatedAtValue.text = direction.updatedAt.relativeTime
    }

}
