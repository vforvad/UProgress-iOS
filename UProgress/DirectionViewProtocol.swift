//
//  DirectionViewProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol DirectionViewProtocol {
    func startLoader()
    func stopLoader()
    func startRefresh()
    func stopRefresh()
    func stopInfiniteScroll()
    func successDirectionsLoad(directions: [Direction]!)
    func failedDirectionsLoad(error: NSError)
    func successLoadMoreDirections(directions: [Direction]!)
}
