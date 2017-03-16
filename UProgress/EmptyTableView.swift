//
//  EmptyTableView.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 16.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class EmptyTableView: UIView {
    @IBOutlet weak var emptyLabel: UILabel!
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "EmptyTableView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
