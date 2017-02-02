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
    var parentVC: SignInProtocol!
    
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
        stackView.spacing = 30.0
        CommonFunctions.customizeTextField(field: self.emailField, placeholder: "Email", image: "email_icon")
        CommonFunctions.customizeTextField(field: self.passwordField, placeholder: "Email", image: "password_icon")
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        let dictionary = ["email": emailField.text!, "password": passwordField.text!]
        parentVC.signInRequest(parameters: dictionary as Dictionary<String, AnyObject> )
    }
}
