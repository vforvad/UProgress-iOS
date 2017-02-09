//
//  DirectionsDetailViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 06.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit

class DirectionsDetailViewController: BaseViewController {
    var direction: Direction!
    private var directionDetailView: DirectionDetailView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        directionDetailView = DirectionDetailView(table: tableView, direction: direction, viewController: self )
    }
}
