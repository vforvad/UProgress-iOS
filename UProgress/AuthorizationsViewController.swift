//
//  AuthorizationsViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 31.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD
import CDAlertView

class AuthorizationsViewController: BaseViewController, SignInProtocol, AuthorizationViewProtocol {
    public var signIn: Bool!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var signInContainer: UIView!
    @IBOutlet weak var signUpContainer: UIView!
    @IBOutlet weak var restorePasswordContainer: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    
    private var presenter: AuthorizationPresenter!
    private var signInView: ErrorsHandling!
    private var signUpView: ErrorsHandling!
    private var restoreView: ErrorsHandling!
    
    private var resetPasswordToken: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor("#f6f7f8")
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        self.segmentControl.setTitle(NSLocalizedString("segment_authorization", comment: ""), forSegmentAt: 0)
        self.segmentControl.setTitle(NSLocalizedString("segment_registration", comment: ""), forSegmentAt: 1)
        self.segmentControl.setTitle(NSLocalizedString("segment_password", comment: ""), forSegmentAt: 2)
        setMVP()
    }
    
    func rotated() {
        var increasingHeight: Int!
        
        if UIDevice.current.orientation.isLandscape {
            if (!signInContainer.isHidden || !restorePasswordContainer.isHidden) {
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
            restorePasswordContainer.isHidden = true
        }
        else if index == 1 {
            segmentControl.selectedSegmentIndex = 1
            signInContainer.isHidden = true
            signUpContainer.isHidden = false
            restorePasswordContainer.isHidden = true
        }
        else if index == 2 {
            segmentControl.selectedSegmentIndex = 2
            signInContainer.isHidden = true
            signUpContainer.isHidden = true
            restorePasswordContainer.isHidden = false
        }
    }
    
    internal func signInRequest(parameters: Dictionary<String, AnyObject>) {
        presenter.signIn(parameters: parameters)
    }
    
    internal func signUpRequest(parameters: Dictionary<String, AnyObject>) {
        presenter.signUp(parameters: parameters)
    }
    
    internal func restorePasswordRequest(parameters: Dictionary<String, AnyObject>) {
        presenter.restorePassword(parameters: parameters)
    }
    
    internal func successSignIn(currentUser: User) {
        if CommonFunctions.DeviceData.isIphone() {
            var viewController = CommonFunctions.fromStoryboard(name: "ProfileStoryboard", identifier: "ProfileViewController") as! ProfileViewController
            viewController.user = currentUser
            sideMenuController?.embed(centerViewController: UINavigationController(rootViewController: viewController))
        }
        else {
            let detailViewController = CommonFunctions.fromStoryboard(name: "ProfileStoryboard", identifier: "ProfileViewController") as! ProfileViewController
            detailViewController.user = currentUser
            let navCtrl = UINavigationController(rootViewController: detailViewController)
            splitViewController?.viewControllers[1] = navCtrl
        }
    }
    
    internal func successRestore(token: String) {
        resetPasswordToken = token
        performSegue(withIdentifier: "reset_password", sender: self)
    }
    
    internal func failedSignIn(error: ServerError) {
        self.signInView.handleErrors(errors: error)
    }
    
    internal func failedSignUp(error: ServerError) {
        self.signUpView.handleErrors(errors: error)
    }
    
    internal func failedRestore(error: ServerError) {
        self.restoreView.handleErrors(errors: error)
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
        
        if segue.identifier == "restore_fragment" {
            let viewController = segue.destination as! RestorePasswordFragmentController
            viewController.parentVC = self
            self.restoreView = viewController
        }
        
        if segue.identifier == "reset_password" {
            let viewController = segue.destination as! ResetPasswordViewController
            viewController.token = resetPasswordToken
        }
     }
    
    internal func stopLoader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    internal func startLoader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    internal func successReset(message: String!) {}
    internal func failedReset(errors: ServerError) {}
    
    deinit {
        NotificationCenter.default.removeObserver(self);
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func scrollToField(view: UIView) {
        scrollView.scrollToView(view: view, animated: true)
    }
    
    @IBAction func unwindToRoot(segue:UIStoryboardSegue) {
        if segue.identifier! == "backSegue" {
            updateSegment(sender: self.segmentControl, index: 0)
            CDAlertView(title: NSLocalizedString("success_title", comment: ""),
                        message: NSLocalizedString("password_reset_success", comment: ""), type: .success).show()

        }
    }
}
