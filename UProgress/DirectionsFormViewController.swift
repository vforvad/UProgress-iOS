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

class DirectionsFormViewController: BasePopupViewController, DirectionFormProtocol {
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
        saveButton.layer.cornerRadius = 8.0
        cancellButton.layer.cornerRadius = 8.0
        
        descriptionField.layer.cornerRadius = 8.0
        descriptionField.layer.borderWidth = 0.3
        descriptionField.layer.borderColor = UIColor.lightGray.cgColor
        self.baseView.layer.cornerRadius = 8.0
        let model = DirectionManager()
        presenter = DirectionFormPresenter(model: model, view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        titleFieldError.isHidden = true
        descriptionFieldError.isHidden = true
        stackView.spacing = 5.0
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
}
