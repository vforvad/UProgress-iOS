//
//  DirectionDetailInfoView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 09.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class DirectionDetailInfoView: UIView {
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var directionRate: UILabel!
    @IBOutlet weak var directionTitle: UILabel!
    var direction: Direction!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        directionRate.backgroundColor = UIColor.gray
        directionRate.layer.masksToBounds = true
        directionRate.layer.cornerRadius = directionRate.frame.size.height / 2
        directionRate.backgroundColor = UIColor("#f6f7f8")
    }
    
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "DirectionDetailInfoView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    public func setDirection(direction: Direction!) {
        self.direction = direction
        self.directionTitle.text = direction.title
        self.directionRate.text =  String(direction.percentsResult)
        self.descriptionText.text = direction.description
    }
    
    public func getHeight() -> CGFloat {
        let descriptionHeight = direction.description.heightWithConstrainedWidth(width: self.frame.size.width, font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 19.0)!)
        let rateHeight = directionRate.frame.size.height
        let titleHeight = directionTitle.frame.size.height
        return descriptionHeight + rateHeight + titleHeight + 30
    }
}
