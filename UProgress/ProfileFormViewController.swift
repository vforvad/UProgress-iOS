//
//  ProfileFormViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 22.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class ProfileFormViewController: BasePopupViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var topMarginView: NSLayoutConstraint!
    
    override var topMargin: NSLayoutConstraint! { get { return topMarginView } }
    override var contentView: UIView! { get { return baseView } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
