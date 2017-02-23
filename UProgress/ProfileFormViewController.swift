//
//  ProfileFormViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 22.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class ProfileFormViewController: BasePopupViewController {
    var user: User! = AuthorizationService.sharedInstance.currentUser
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
    }
    
    @IBAction func saveClick(_ sender: Any) {
        
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    func setAppearance() {
        firstNameFieldError.isHidden = true
        lastNameFieldError.isHidden = true
        emailFieldError.isHidden = true
        locationFieldError.isHidden = true
        stackView.spacing = 20.0
        
        descriptionField.layer.cornerRadius = 8.0
        descriptionField.layer.borderWidth = 0.3
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        
        firstNameField.placeholder = "First name"
        lastNameField.placeholder = "Last name"
        emailField.placeholder = "Email"
        locationField.placeholder = "Location"
        
        saveButton.layer.cornerRadius = 4.0
        cancelButton.layer.cornerRadius = 4.0
    }
    
    func setValues() {
        firstNameField.text = user.firstName
        lastNameField.text = user.lastName
        emailField.text = user.email
        locationField.text = user.location
        descriptionField.text = user.description
    }
}
