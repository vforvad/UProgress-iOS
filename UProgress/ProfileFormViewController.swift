//
//  ProfileFormViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 22.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class ProfileFormViewController: BasePopupViewController, ProfileViewProtocol, UITextViewDelegate, UITextFieldDelegate {
    var presenter: ProfilePresenter!
    var user: User! = AuthorizationService.sharedInstance.currentUser
    var actions: ProfilePopupProtocol!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var topMarginView: NSLayoutConstraint!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var firstNameFieldError: UILabel!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var lastNameFieldError: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailFieldError: UILabel!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var locationFieldError: UILabel!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    override var topMargin: NSLayoutConstraint! { get { return topMarginView } }
    override var contentView: UIView! { get { return baseView } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setAppearance()
        setValues()
        let model = ProfileManager()
        presenter = ProfilePresenter(model: model, view: self)
        
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.emailField.delegate = self
        self.locationField.delegate = self
        self.descriptionField.delegate = self
    }
    
    @IBAction func saveClick(_ sender: Any) {
        hideErrors()
        let userId: String! = String(user.id)
        let parameters = [
            "first_name": firstNameField.text,
            "last_name": lastNameField.text,
            "email": emailField.text,
            "location": locationField.text,
            "description": getDescription(),
            "attachment": user.attachment?.toDict()
        ] as [String : Any]
        
        presenter.updateProfile(userId: userId, parameters: parameters as Dictionary<String, AnyObject>)
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    func hideErrors() {
        firstNameFieldError.isHidden = true
        lastNameFieldError.isHidden = true
        emailFieldError.isHidden = true
        locationFieldError.isHidden = true
        stackView.spacing = 20.0
    }
    
    func setAppearance() {
        hideErrors()
        
        descriptionField.layer.cornerRadius = 8.0
        descriptionField.layer.borderWidth = 0.3
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        
        firstNameField.placeholder = NSLocalizedString("profile_first_name", comment: "")
        lastNameField.placeholder = NSLocalizedString("profile_last_name", comment: "")
        emailField.placeholder = NSLocalizedString("profile_email", comment: "")
        locationField.placeholder = NSLocalizedString("profile_location", comment: "")
        descriptionField.text = NSLocalizedString("profile_about", comment: "")
        saveButton.setTitle(NSLocalizedString("form_save", comment: ""), for: .normal)
        cancelButton.setTitle(NSLocalizedString("form_cancel", comment: ""), for: .normal)
        saveButton.layer.cornerRadius = 4.0
        cancelButton.layer.cornerRadius = 4.0
    }
    
    func setValues() {
        firstNameField.text = user.firstName
        lastNameField.text = user.lastName
        emailField.text = user.email
        locationField.text = user.location
        if user.description != nil && !user.description.isEmpty {
            descriptionField.text = user.description
        }
        else {
            descriptionField.text = NSLocalizedString("profile_about", comment: "")
            descriptionField.textColor = UIColor.lightGray
        }
    }
    
    internal func successUpdate(user: User!) {
        self.dismiss(animated: true, completion: {
            self.actions.successUserUpdate(user: user)
        })
    }
    
    internal func failedUpdate(error: ServerError!) {
        self.stackView.spacing = 5.0
        let errorsList = error.params!
        if let titleErrorsArr = errorsList["first_name"] {
            let errorsArr = titleErrorsArr as! [String]
            let titleError: String! = errorsArr.joined(separator: "\n")
            self.firstNameFieldError.text = titleError
            self.firstNameFieldError.isHidden = false
            
        }
        
        if errorsList["last_name"] != nil {
            let errorsArr = errorsList["last_name"] as! [String]
            let descriptionError: String! = errorsArr.joined(separator: "\n")
            self.lastNameFieldError.text = descriptionError
            self.lastNameFieldError.isHidden = false
        }
        
        if errorsList["email"] != nil {
            let errorsArr = errorsList["email"] as! [String]
            let descriptionError: String! = errorsArr.joined(separator: "\n")
            self.emailFieldError.text = descriptionError
            self.emailFieldError.isHidden = false
        }
    }
    
    internal func startLoader() {
        MBProgressHUD.showAdded(to: self.view, animated: true)
    }
    
    internal func stopLoader() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    // MARK: UITextViewDelegate methods
    func textViewDidBeginEditing(_ textView: UITextView) {
        if descriptionField.textColor == UIColor.lightGray {
            descriptionField.text = nil
            descriptionField.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if descriptionField.text.isEmpty {
            descriptionField.text = NSLocalizedString("profile_about", comment: "")
            descriptionField.textColor = UIColor.lightGray
        }
    }
    

    
    // MARK: UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField === firstNameField {
            firstNameField.resignFirstResponder()
            self.scrollView.scrollToView(view: lastNameField, animated: true)
            lastNameField.becomeFirstResponder()
        }
        
        if textField == lastNameField {
            lastNameField.resignFirstResponder()
            self.scrollView.scrollToView(view: emailField, animated: true)
            emailField.becomeFirstResponder()
        }
        
        if textField == emailField {
            emailField.resignFirstResponder()
            self.scrollView.scrollToView(view: locationField, animated: true)
            locationField.becomeFirstResponder()
        }
        
        if textField == locationField {
            locationField.resignFirstResponder()
            self.scrollView.scrollToView(view: descriptionField, animated: true)
            descriptionField.becomeFirstResponder()
        }
        return true
    }
    
    func getDescription() -> String? {
        if descriptionField.text == NSLocalizedString("profile_about", comment: "") {
            return nil
        }
        return descriptionField.text
    }
}
