//
//  StepDetailViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 15.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class StepDetailViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewMarginTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTap(_:)))
        self.view.addGestureRecognizer(gesture)
    }
    
    func viewTap(_ sender:UITapGestureRecognizer) {
        if sender.view != mainView {
            self.dismiss(animated: true, completion: {})
        }
    }
}
