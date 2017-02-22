//
//  BasePopupViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 23.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class BasePopupViewController: UIViewController {
    var topMargin: NSLayoutConstraint! { get { return nil } }
    var contentView: UIView! { get { return nil } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBlurView()
        setOuterGesture()
        if contentView != nil {
            self.contentView.layer.cornerRadius = 8.0
        }
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        if self.topMargin != nil {
            if CommonFunctions.DeviceData.isOrientationLandscape() {
                if CommonFunctions.DeviceData.isIPad() {
                    self.topMargin.constant = 60
                }
                else {
                    self.topMargin.constant = self.view.frame.size.width / 5
                }
            }
        }
    }
    
    func rotated() {
        if self.topMargin != nil {
            if CommonFunctions.DeviceData.isOrientationPortrait() {
                self.topMargin.constant = self.view.frame.size.width / 2
            }
            else {
                self.topMargin.constant = 30
            }
        }
    }
    
    func setBlurView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
    }
    
    func setOuterGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTap(_:)))
        self.view.addGestureRecognizer(gesture)
    }
    
    func viewTap(_ sender:UITapGestureRecognizer) {
        if contentView != nil && sender.view != contentView {
            self.dismiss(animated: true, completion: {})
        }
    }
}
