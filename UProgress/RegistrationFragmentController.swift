//
//  RegistrationFragment.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import CDAlertView

class RegistrationFragmentController: BaseViewController, ErrorsHandling, UITextFieldDelegate {
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
        self.view.backgroundColor = UIColor.white
        self.view.layer.cornerRadius = 10.0
        
        emailField.delegate = self
        passwordField.delegate = self
        passwordConfirmationField.delegate = self
        nickField.delegate = self
        
        signUpButton.setTitle(NSLocalizedString("auth_sign_up", comment: ""), for: UIControlState.normal)
        signUpButton.layer.cornerRadius = 5.0
        emailErrors.isHidden = true
        passwordErrors.isHidden = true
        passwordConfirmationErrors.isHidden = true
        nickErrors.isHidden = true
        hideErrors()
        CommonFunctions.customizeTextField(field: self.emailField, placeholder: NSLocalizedString("auth_email", comment: ""), image: "email_icon")
        CommonFunctions.customizeTextField(field: self.passwordField, placeholder: NSLocalizedString("auth_password", comment: ""), image: "password_icon")
        CommonFunctions.customizeTextField(field: self.passwordConfirmationField, placeholder: NSLocalizedString("auth_password_confirmation", comment: ""), image: "password_icon")
        CommonFunctions.customizeTextField(field: self.nickField, placeholder: NSLocalizedString("auth_nick", comment: ""), image: "user_nick")
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
        switch(errors.status!) {
        case 400 ... 499:
            handleFormErrors(errors: errors)
        default:
            CDAlertView(title: NSLocalizedString("error_title", comment: ""),
                        message: NSLocalizedString("server_not_respond", comment: ""), type: .error).show()
        }
    }
    
    private func handleFormErrors(errors: ServerError) {
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
    
    // MARK: UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if (textField === emailField) {
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
        }
        if textField == passwordField {
            passwordField.resignFirstResponder()
            passwordConfirmationField.becomeFirstResponder()
        }
        if textField == passwordConfirmationField {
            passwordConfirmationField.resignFirstResponder()
            nickField.becomeFirstResponder()
        }
        if textField == nickField {
            self.signUp(signUpButton)
        }
        return true
    }
}
