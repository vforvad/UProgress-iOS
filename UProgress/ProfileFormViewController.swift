//
//  ProfileFormViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 22.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class ProfileFormViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var baseView: UIView!
    override func viewDidLoad() {
         super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
        
        self.baseView.layer.cornerRadius = 8.0
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTap(_:)))
        self.view.addGestureRecognizer(gesture)
    }
    
    func viewTap(_ sender:UITapGestureRecognizer) {
        if sender.view != baseView {
            self.dismiss(animated: true, completion: {})
        }
    }
}
