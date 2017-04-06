//
//  ResetPasswordViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.04.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import CDAlertView

class ResetPasswordViewController: BaseViewController, UITextFieldDelegate, AuthorizationViewProtocol {
    var token: String!
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordFieldError: UILabel!
    @IBOutlet weak var passwordConfirmationField: UITextField!
    @IBOutlet weak var passwordConfirmationFieldError: UILabel!
    @IBOutlet weak var resetPasswordButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    private var presenter: AuthorizationPresenter!
    
    override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = UIColor("#f6f7f8")
        hideErrors()
        
        let model = AuthorizationManager()
        
        baseView.layer.cornerRadius = 8.0
        
        resetPasswordButton.setTitle(NSLocalizedString("auth_reset_password", comment: ""), for: UIControlState.normal)
        resetPasswordButton.layer.cornerRadius = 5.0
        
        CommonFunctions.customizeTextField(field: self.passwordField, placeholder: NSLocalizedString("auth_password", comment: ""), image: "password_icon")
        CommonFunctions.customizeTextField(field: self.passwordConfirmationField, placeholder: NSLocalizedString("auth_password_confirmation", comment: ""), image: "password_icon")
        
        presenter = AuthorizationPresenter(model: model, view: self)
    }
    
    private func hideErrors() {
        passwordFieldError.isHidden = true
        passwordConfirmationFieldError.isHidden = true
        stackView.spacing = Constants.authDefaultSpacing
    }
    
    @IBAction func resetPassword(_ sender: Any) {
        hideErrors()
        let dictionary = ["password": passwordField.text!, "password_confirmation": passwordConfirmationField.text!, "token": token]
        presenter.resetPassword(parameters: dictionary as Dictionary<String, AnyObject> )
    }
    
    internal func successReset(message: String!) {
        let authViewController = CommonFunctions.fromStoryboard(name: "AuthorizationStoryboard", identifier: "AuthorizationViewController") as! AuthorizationsViewController
        authViewController.signIn = true
        performSegue(withIdentifier: "backSegue", sender: self)
    }
    
    internal func failedReset(errors: ServerError) {
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
        if errorsList!["password"]! != nil {
            let errorsArr = errorsList!["password"]! as! [String]
            let passwordError: String! = errorsArr.joined(separator: "\n")
            self.passwordFieldError.text = passwordError
            self.passwordFieldError.isHidden = false
            
        }
        
        if errorsList?["password_confirmation"]! != nil {
            let errorsArr = errorsList?["password_confirmation"] as! [String]
            let passwordError: String! = errorsArr.joined(separator: "\n")
            self.passwordConfirmationFieldError.text = passwordError
            self.passwordConfirmationFieldError.isHidden = false
        }
        
        if errorsList!["user"]! != nil {
            let errorsArr = errorsList!["user"]! as! [String]
            let userError: String! = errorsArr.joined(separator: "\n")
            CDAlertView(title: NSLocalizedString("error_title", comment: ""),
                        message: userError, type: .error).show()
        }
        
        if errorsList!["token"]! != nil {
            let errorsArr = errorsList!["token"]! as! [String]
            let userError: String! = errorsArr.joined(separator: "\n")
            CDAlertView(title: NSLocalizedString("error_title", comment: ""),
                        message: userError, type: .error).show()
        }
    }
    
    
    
    internal func startLoader() { MBProgressHUD.showAdded(to: view, animated: true) }
    internal func stopLoader() { MBProgressHUD.hide(for: view, animated: true) }
    
    internal func successSignIn(currentUser: User) {  }
    internal func failedSignIn(error: ServerError) {  }
    internal func failedSignUp(error: ServerError) {  }
    
    internal func successRestore(token: String) {  }
    internal func failedRestore(error: ServerError) {  }
}
