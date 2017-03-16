//
//  DirectionFormViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 09.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import MBProgressHUD
import UIKit
import CDAlertView

class StepFormViewController: BasePopupViewController, StepViewProtocol, UITextViewDelegate, UITextFieldDelegate {
    var defaultKeyboardSize: CGFloat!
    var mainView: DirectionsPopupProtocol!
    var presenter: StepPresenter!
    var direction: Direction!
    var user: User! = AuthorizationService.sharedInstance.currentUser
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var popupTopMargin: NSLayoutConstraint!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var titleFieldError: UILabel!
    @IBOutlet weak var descriptionFieldError: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancellButton: UIButton!
    
    override var topMargin: NSLayoutConstraint! { get { return popupTopMargin } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleField.delegate = self
        saveButton.layer.cornerRadius = 8.0
        cancellButton.layer.cornerRadius = 8.0
        
        titleField.placeholder = NSLocalizedString("directions_title", comment: "")
        descriptionField.text = NSLocalizedString("directions_description", comment: "")
        descriptionField.textColor = UIColor.lightGray
        descriptionField.delegate = self
        descriptionField.layer.cornerRadius = 8.0
        descriptionField.layer.borderWidth = 0.3
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        self.popupView.layer.cornerRadius = 8.0
        let model = DirectionDetailManager()
        presenter = StepPresenter(model: model, view: self)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleFieldError.isHidden = true
        descriptionFieldError.isHidden = true
    }
    
    @IBAction func clickSave(_ sender: Any) {
        self.titleFieldError.isHidden = true
        self.descriptionFieldError.isHidden = true
        let directionId: String = String(self.direction.id)
        let parameters = ["title": self.titleField.text, "description": getDescription()]
        presenter.createStep(userId: user.nick, directionId: directionId, parameters: parameters as Dictionary<String, AnyObject> )
    }
    @IBAction func clickCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    internal func successCreation(step: Step!) {
        self.dismiss(animated: true, completion: {
            self.mainView.successOperation(step: step)
        })
    }
    
    internal func failureCreation(error: ServerError!) {
        switch(error.status!) {
        case 400 ... 499:
            handleFormError(error: error)
        default:
            CDAlertView(title: NSLocalizedString("error_title", comment: ""),
                        message: NSLocalizedString("server_not_respond", comment: ""), type: .error).show()
        }

    }
    
    private func handleFormError(error: ServerError!) {
        let errorsList = error.params!["errors"]
        if let titleErrorsArr = errorsList?["title"] {
            let errorsArr = titleErrorsArr as! [String]
            let titleError: String! = errorsArr.joined(separator: "\n")
            self.titleFieldError.text = titleError
            self.titleFieldError.isHidden = false
            
        }
        
        if errorsList?["description"]! != nil {
            let errorsArr = errorsList?["description"] as! [String]
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
            descriptionField.text = NSLocalizedString("directions_description", comment: "")
            descriptionField.textColor = UIColor.lightGray
        }
    }
    
    func getDescription() -> String? {
        if descriptionField.text! == NSLocalizedString("directions_description", comment: "") {
            return nil
        }
        return descriptionField.text
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
