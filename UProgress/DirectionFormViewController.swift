//
//  DirectionFormViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 09.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

class DirectionFormViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
