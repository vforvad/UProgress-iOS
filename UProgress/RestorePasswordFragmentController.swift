//
//  RestorePasswordViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.04.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class RestorePasswordFragmentController: BaseViewController, UITextFieldDelegate {
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
    
    @IBAction func restorePassword(_ sender: Any) {
    }
}
