//
//  AuthorizationFragment.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationFragmentController: BaseViewController, ErrorsHandling {
    var parentVC: SignInProtocol!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBOutlet weak var emailErrors: UILabel!
    @IBOutlet weak var passwordErrors: UILabel!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideErrors()
        CommonFunctions.customizeTextField(field: self.emailField, placeholder: "Email", image: "email_icon")
        CommonFunctions.customizeTextField(field: self.passwordField, placeholder: "Email", image: "password_icon")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        hideErrors()
        let dictionary = ["email": emailField.text!, "password": passwordField.text!]
        parentVC.signInRequest(parameters: dictionary as Dictionary<String, AnyObject> )
    }
    
    func handleErrors(errors: ServerError) {
        stackView.spacing = Constants.authErrorSpacing
        let errorsList = errors.params!
        if let emailErrorsArr = errorsList["email"] {
            let errorsArr = emailErrorsArr as! [String]
            let emailError: String! = errorsArr.joined(separator: "\n")
            self.emailErrors.text = emailError
            self.emailErrors.isHidden = false

        }
        
        if errorsList["password"] != nil {
            let errorsArr = errorsList["password"] as! [String]
            let passwordError: String! = errorsArr.joined(separator: "\n")
            self.passwordErrors.text = passwordError
            self.passwordErrors.isHidden = false
        }
    }
    
    private func hideErrors() {
        emailErrors.isHidden = true
        passwordErrors.isHidden = true
        stackView.spacing = Constants.authDefaultSpacing
    }
}
