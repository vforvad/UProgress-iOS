//
//  DirectionsListViewProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol DirectionsListViewProtocol {
    func clickOnItem(direction: Direction, indexPath: IndexPath!)
    func refreshTriggered()
    func infiniteScrollTriggered()
}
