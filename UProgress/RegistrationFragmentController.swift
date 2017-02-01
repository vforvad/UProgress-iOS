//
//  RegistrationFragment.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class RegistrationFragmentController:BaseViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordConfirmationField: UITextField!
    @IBOutlet weak var nickField: UITextField!
    
    
    @IBOutlet weak var emailErrors: UILabel!
    @IBOutlet weak var passwordErrors: UILabel!
    @IBOutlet weak var passwordConfirmationErrors: UILabel!
    @IBOutlet weak var nickErrors: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailErrors.isHidden = true
        passwordErrors.isHidden = true
        passwordConfirmationErrors.isHidden = true
        nickErrors.isHidden = true
        
        CommonFunctions.customizeTextField(field: self.emailField, placeholder: "Email", image: "email_icon")
        CommonFunctions.customizeTextField(field: self.passwordField, placeholder: "Email", image: "password_icon")
        CommonFunctions.customizeTextField(field: self.passwordConfirmationField, placeholder: "Email", image: "password_icon")
        CommonFunctions.customizeTextField(field: self.nickField, placeholder: "Email", image: "user_nick")
    }
    
    @IBAction func signUp(_ sender: Any) {
    }
}
