//
//  DirectionsFormViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 27.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class DirectionsFormViewController: BasePopupViewController, DirectionFormProtocol, UITextViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    var actions: DirectionPopupActions!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancellButton: UIButton!
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var titleFieldError: UILabel!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var descriptionFieldError: UILabel!
    
    @IBOutlet weak var topMarginBaseView: NSLayoutConstraint!
    
    override var topMargin: NSLayoutConstraint! { get { return topMarginBaseView } }
    override var contentView: UIView! { get { return baseView } }
    
    private var presenter: DirectionFormPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        titleField.delegate = self
        saveButton.layer.cornerRadius = 8.0
        cancellButton.layer.cornerRadius = 8.0
        
        descriptionField.layer.cornerRadius = 8.0
        descriptionField.layer.borderWidth = 0.3
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        self.baseView.layer.cornerRadius = 8.0
        
        saveButton.setTitle(NSLocalizedString("form_save", comment: ""), for: .normal)
        cancellButton.setTitle(NSLocalizedString("form_cancel", comment: ""), for: .normal)
        
        let model = DirectionManager()
        presenter = DirectionFormPresenter(model: model, view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        titleFieldError.isHidden = true
        descriptionFieldError.isHidden = true
        stackView.spacing = 5.0
        
        descriptionField.delegate = self
        titleField.placeholder = NSLocalizedString("directions_title", comment: "")
        
        descriptionField.text = NSLocalizedString("directions_description", comment: "")
        descriptionField.textColor = UIColor.lightGray
    }
    
    @IBAction func clickSave(_ sender: Any) {
        titleFieldError.isHidden = true
        descriptionFieldError.isHidden = true
        presenter.createDirection(userNick: AuthorizationService.sharedInstance.currentUser.nick,
                                  parameters: ["title": titleField.text, "description": descriptionField.text]
        )
        
    }
    @IBAction func clickCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    internal func successCreation(direction: Direction) {
        actions.successOperation(direction: direction)
        self.dismiss(animated: true, completion: {})
    }
    
    internal func failedCreation(error: ServerError) {
        let errorsList = error.params!
        if let titleErrorsArr = errorsList["title"] {
            let errorsArr = titleErrorsArr as! [String]
            let titleError: String! = errorsArr.joined(separator: "\n")
            self.titleFieldError.text = titleError
            self.titleFieldError.isHidden = false
        }
        
        if errorsList["description"] != nil {
            let errorsArr = errorsList["description"] as! [String]
            let descriptionError: String! = errorsArr.joined(separator: "\n")
            self.descriptionFieldError.text = descriptionError
            self.descriptionFieldError.isHidden = false
        }
    }
    
    internal func startLoader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    internal func stopLoader() {
        MBProgressHUD.hide(for: view, animated: true)
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
            descriptionField.text = NSLocalizedString("directions_descriptions", comment: "")
            descriptionField.textColor = UIColor.lightGray
        }
    }
    
    // MARK: UITextFieldDelegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if textField === titleField {
            titleField.resignFirstResponder()
            self.scrollView.scrollToView(view: descriptionField, animated: true)
            descriptionField.becomeFirstResponder()
        }
        return true
    }
}
