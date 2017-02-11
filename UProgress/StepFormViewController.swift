//
//  DirectionFormViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 09.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class StepFormViewController: UIViewController, StepViewProtocol {
    var defaultKeyboardSize: CGFloat!
    var mainView: DirectionsPopupProtocol!
    var presenter: StepPresenter!
    var direction: Direction!
    var user: User! = AuthorizationService.sharedInstance.currentUser
    
    @IBOutlet weak var popupTopMargin: NSLayoutConstraint!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var titleFieldError: UILabel!
    @IBOutlet weak var descriptionFieldError: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancellButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        self.popupTopMargin.constant = self.view.frame.size.width / 2
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
        var model = DirectionDetailManager()
        presenter = StepPresenter(model: model, view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleFieldError.isHidden = true
        descriptionFieldError.isHidden = true
    }
    
    @IBAction func clickSave(_ sender: Any) {
        let directionId: String = String(self.direction.id)
        var parameters: Dictionary<String, AnyObject>! = ["title": self.titleField.text as String! as AnyObject, "description": self.descriptionField.text as String! as AnyObject]
        presenter.createStep(userId: user.nick, directionId: directionId, parameters: parameters )
    }
    @IBAction func clickCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    
    func rotated() {
        if CommonFunctions.DeviceData.isOrientationPortrait() {
            self.popupTopMargin.constant = self.view.frame.size.width / 2
        }
        else {
            self.popupTopMargin.constant = 30
        }
    }
    
    internal func successCreation(step: Step!) {
        self.dismiss(animated: true, completion: {
            self.mainView.successOperation(step: step)
        })
    }
    
    internal func failureCreation(error: ServerError!) {
    
    }
}
