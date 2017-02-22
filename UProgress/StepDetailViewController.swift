//
//  StepDetailViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 15.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class StepDetailViewController: BasePopupViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewMarginTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override var topMargin: NSLayoutConstraint! { get { return viewMarginTopConstraint } }
    override var contentView: UIView! { get { return mainView } }
    
    var step: Step!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.layer.cornerRadius = 8.0
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(blurEffectView, at: 0)
        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTap(_:)))
//        self.view.addGestureRecognizer(gesture)
        
        let descriptionHeight = step.description.heightWithConstrainedWidth(width: self.descriptionLabel.frame.size.width, font: UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17.0)!)
        let titleHeight = step.title.heightWithConstrainedWidth(width: self.titleLabel.frame.size.width, font: UIFont(name: "HelveticaNeue-Bold", size: 19.0)!)
        viewHeightConstraint.constant = descriptionHeight + titleHeight + 30
        
        titleLabel.text = step.title
        titleLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
        descriptionLabel.text = step.description
    }
    
//    func viewTap(_ sender:UITapGestureRecognizer) {
//        if sender.view != mainView {
//            self.dismiss(animated: true, completion: {})
//        }
//    }
}
