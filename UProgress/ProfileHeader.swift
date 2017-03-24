//
//  ProfileHeader.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 19.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class ProfileHeader: UIView {
    var user: User!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userNick: UILabel!

    
    func setData(user: User!) {
        backgroundColor = UIColor("#82D57E")
        self.user = user
        CommonFunctions.avatarImage(imageView: avatarImage, url: user.avatarUrl)
        userName.text = user.getFullName()
        userNick.text = user.getCorrectNick()
        userName.textColor = UIColor.white
        userNick.textColor = UIColor.white
        
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "ProfileHeader", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    func updateAvatar(image: UIImage!) {
        CommonFunctions.avatarImage(imageView: avatarImage, image: image)
    }
}
