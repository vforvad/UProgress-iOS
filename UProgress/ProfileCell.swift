//
//  ProfileCell.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 19.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class ProfileCell: UITableViewCell {
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var infoValue: UILabel!
    @IBOutlet weak var wrapper: UIView!
    
    func setData(list: Dictionary<String, String>!) {
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let underlineAttributedString = NSAttributedString(string: (list["title"]?.capitalizingFirstLetter())!, attributes: underlineAttribute)
        infoTitle.attributedText = underlineAttributedString
        wrapper.layer.cornerRadius = 8.0
        self.backgroundColor = UIColor.clear
        infoTitle.tintColor = UIColor.lightGray
        
        infoValue.text = list["value"]
    }

}
