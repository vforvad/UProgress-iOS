//
//  ProfileViewCell.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 05.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class ProfileViewCell: UITableViewCell {
    var user: User!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    
    
    public func setData(user: User!) {
        self.user = user
        CommonFunctions.avatarImage(imageView: profileImage, url: user.avatarUrl)
        self.profileName.text = user.nick

    }
}
