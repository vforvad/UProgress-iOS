//
//  AuthorizationsViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 31.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationsViewController: BaseViewController {
    public var signIn: Bool!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        var authView = AuthorizationFragment.initWith(nibName: "AuthorizationFragment") as! AuthorizationFragment
//        contentView.addSubview(authView)
    }
}
