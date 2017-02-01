//
//  AuthorizationsViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 31.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationsViewController: BaseViewController {
    public var signIn: Bool!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var signInContainer: UIView!
    @IBOutlet weak var signUpContainer: UIView!
    
    override func viewDidLoad() {
         super.viewDidLoad()
        if signIn! {
            segmentControl.selectedSegmentIndex = 0
            signInContainer.isHidden = false
            signUpContainer.isHidden = true
        } else {
            segmentControl.selectedSegmentIndex = 1
            signInContainer.isHidden = true
            signUpContainer.isHidden = false
        }
    }
    
    @IBAction func toggleController(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            signInContainer.isHidden = false
            signUpContainer.isHidden = true
        }
        else if sender.selectedSegmentIndex == 1 {
            signInContainer.isHidden = true
            signUpContainer.isHidden = false
        }
    }
}
