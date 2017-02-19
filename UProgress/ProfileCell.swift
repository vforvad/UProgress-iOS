//
//  ProfileCell.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 19.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class ProfileCell: UITableViewCell {
    @IBOutlet weak var infoTitle: UILabel!
    @IBOutlet weak var infoValue: UILabel!
    
    func setData(list: Dictionary<String, String>!) {
        infoTitle.tintColor = UIColor.lightGray
        infoTitle.text = list["title"]?.capitalizingFirstLetter()
        infoValue.text = list["value"]
    }

}
