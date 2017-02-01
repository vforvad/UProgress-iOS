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
        updateSegment(sender: self.segmentControl, index: (signIn! ? 0 : 1))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func toggleController(_ sender: UISegmentedControl) {
        updateSegment(sender: sender, index: sender.selectedSegmentIndex)
    }
    
    private func updateSegment(sender: UISegmentedControl, index: Int!) {
        if index == 0 {
            segmentControl.selectedSegmentIndex = 0
            signInContainer.isHidden = false
            signUpContainer.isHidden = true
        }
        else if index == 1 {
            segmentControl.selectedSegmentIndex = 1
            signInContainer.isHidden = true
            signUpContainer.isHidden = false
        }
    }
}
