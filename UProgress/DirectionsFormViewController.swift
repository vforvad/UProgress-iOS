//
//  DirectionsFormViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 27.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class DirectionsFormViewController: BasePopupViewController {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        titleFieldError.isHidden = true
        descriptionFieldError.isHidden = true
        stackView.spacing = 5.0
    }
    @IBAction func clickSave(_ sender: Any) {
        
    }
    @IBAction func clickCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
}
