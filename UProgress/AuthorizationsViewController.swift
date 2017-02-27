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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    
    private var presenter: AuthorizationPresenter!
    private var signInView: ErrorsHandling!
    private var signUpView: ErrorsHandling!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor("#f6f7f8")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        self.segmentControl.setTitle(NSLocalizedString("segment_authorization", comment: ""), forSegmentAt: 0)
        self.segmentControl.setTitle(NSLocalizedString("segment_registration", comment: ""), forSegmentAt: 1)
        setMVP()
    }
    
    func rotated() {
        var increasingHeight: Int!
        
        if UIDevice.current.orientation.isLandscape {
            if (!signInContainer.isHidden) {
                increasingHeight = 2 * 40 + 50
            }
            else {
                increasingHeight = 4 * 40 + 50
            }
//            signUpContainer.frame.size = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height +  CGFloat(increasingHeight))
            self.scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.frame.size.height +  CGFloat(increasingHeight))
        }

    }
    
    func keyboardDidShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let realSize = UIDevice.current.orientation.isPortrait ? keyboardSize.height / 2 : keyboardSize.height
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: realSize, right: 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    private func setMVP() {
        let model = AuthorizationManager()
        presenter = AuthorizationPresenter(model: model, view: self)
        updateSegment(sender: self.segmentControl, index: (signIn! ? 0 : 1))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor("#f6f7f8")
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
    
    internal func signUpRequest(parameters: Dictionary<String, AnyObject>) {
        presenter.signUp(parameters: parameters)
    }
    
    internal func successSignIn(currentUser: User) {
        var viewController = CommonFunctions.fromStoryboard(name: "ProfileStoryboard", identifier: "ProfileViewController") as! ProfileViewController
        viewController.user = currentUser
        sideMenuController?.embed(centerViewController: UINavigationController(rootViewController: viewController))
    }
    
    internal func failedSignIn(error: ServerError) {
        self.signInView.handleErrors(errors: error)
    }
    
    internal func failedSignUp(error: ServerError) {
        self.signUpView.handleErrors(errors: error)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "auth_fragment" {
            let viewController = segue.destination as! AuthorizationFragmentController
            viewController.view.translatesAutoresizingMaskIntoConstraints = false;
            viewController.parentVC = self
            self.signInView = viewController
        }
        
        if segue.identifier == "reg_fragment" {
            let viewController = segue.destination as! RegistrationFragmentController
            viewController.parentVC = self
            self.signUpView = viewController
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
}
