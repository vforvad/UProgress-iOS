//
//  RestorePasswordViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.04.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import CDAlertView

class RestorePasswordFragmentController: BaseViewController, ErrorsHandling, UITextFieldDelegate {
    var parentVC: SignInProtocol!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailFieldError: UILabel!
    @IBOutlet weak var restorePasswordButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideErrors()
        self.view.backgroundColor = UIColor.white
        self.view.layer.cornerRadius = 10.0
        
        restorePasswordButton.setTitle(NSLocalizedString("auth_password", comment: ""), for: UIControlState.normal)
        restorePasswordButton.layer.cornerRadius = 5.0
        
        emailField.delegate = self
        
        CommonFunctions.customizeTextField(field: self.emailField, placeholder: NSLocalizedString("auth_email", comment: ""), image: "email_icon")
    }
    
    
    // MARK: UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if (textField === emailField) {
            parentVC.scrollToField(view: restorePasswordButton)
            restorePassword(restorePasswordButton)
        }
        return true
    }
    
    private func hideErrors() {
        emailFieldError.isHidden = true
        stackView.spacing = Constants.authDefaultSpacing
    }
    
    func handleErrors(errors: ServerError) {
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
        let errorsList = errors.params!["errors"]
        if let emailErrorsArr = errorsList?["email"] {
            let errorsArr = emailErrorsArr as! [String]
            let emailError: String! = errorsArr.joined(separator: "\n")
            self.emailFieldError.text = emailError
            self.emailFieldError.isHidden = false
            
        }
    }
    
    @IBAction func restorePassword(_ sender: Any) {
        hideErrors()
        let dictionary = ["email": emailField.text!]
        parentVC.restorePasswordRequest(parameters: dictionary as Dictionary<String, AnyObject> )
    }
}
