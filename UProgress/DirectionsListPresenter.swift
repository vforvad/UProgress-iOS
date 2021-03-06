//
//  DirectionsListPresenterProtocol.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 29.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation

protocol DirectionsListPresenter {
    func loadDirections(userNick: String!)
    func reloadDirectionsList(userNick: String!)
    func loadMoreDirections(userNick: String!)
}
