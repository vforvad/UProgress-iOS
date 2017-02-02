//
//  RegistrationFragment.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class RegistrationFragmentController: BaseViewController, ErrorsHandling {
    var parentVC: SignInProtocol!
    
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
        hideErrors()
        CommonFunctions.customizeTextField(field: self.emailField, placeholder: "Email", image: "email_icon")
        CommonFunctions.customizeTextField(field: self.passwordField, placeholder: "Email", image: "password_icon")
        CommonFunctions.customizeTextField(field: self.passwordConfirmationField, placeholder: "Email", image: "password_icon")
        CommonFunctions.customizeTextField(field: self.nickField, placeholder: "Email", image: "user_nick")
    }
    
    @IBAction func signUp(_ sender: Any) {
        hideErrors()
        let dictionary = ["email": emailField.text!, "password": passwordField.text!,
                          "password_confirmation": passwordConfirmationField.text!, "nick": nickField.text!]
        parentVC.signUpRequest(parameters: dictionary as Dictionary<String, AnyObject>)
    }
    
    private func hideErrors() {
        emailErrors.isHidden = true
        passwordErrors.isHidden = true
        passwordConfirmationErrors.isHidden = true
        nickErrors.isHidden = true
        stackView.spacing = Constants.authDefaultSpacing
    }
    
    internal func handleErrors(errors: ServerError) {
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
        
        if errorsList["password_confirmation"] != nil {
            let errorsArr = errorsList["password_confirmation"] as! [String]
            let passwordConfError: String! = errorsArr.joined(separator: "\n")
            self.passwordConfirmationErrors.text = passwordConfError
            self.passwordConfirmationErrors.isHidden = false
        }
        
        if errorsList["nick"] != nil {
            let errorsArr = errorsList["nick"] as! [String]
            let nickError: String! = errorsArr.joined(separator: "\n")
            self.nickErrors.text = nickError
            self.nickErrors.isHidden = false
        }
    }
}
