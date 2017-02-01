//
//  AuthorizationFragment.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationFragmentController: BaseViewController {
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var emailErrors: UILabel!
    @IBOutlet weak var passwordErrors: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailErrors.isHidden = true
        passwordErrors.isHidden = true
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        emailErrors.isHidden = false
        passwordErrors.isHidden = false
    }
}
