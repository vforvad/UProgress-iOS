//
//  AuthorizationsViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 31.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class AuthorizationsViewController: BaseViewController, SignInProtocol, AuthorizationViewProtocol {
    public var signIn: Bool!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var signInContainer: UIView!
    @IBOutlet weak var signUpContainer: UIView!
    
    private var presenter: AuthorizationPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.addChildViewController(<#T##childController: UIViewController##UIViewController#>)
        let model = AuthorizationManager()
        presenter = AuthorizationPresenter(model: model, view: self)
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
    
    internal func signInRequest(parameters: Dictionary<String, AnyObject>) {
        presenter.signIn(parameters: parameters)
    }
    
    internal func successSignIn(currentUser: User) {
    
    }
    
    internal func failedSignIn(error: NSError) {
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "auth_fragment" {
            var viewController = segue.destination as! AuthorizationFragmentController
            viewController.parentVC = self
        }
        
    }
}
