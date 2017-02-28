//
//  StatisticsViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 28.02.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class StatisticsViewController: BaseViewController, StatisticsViewProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    internal func successStatisticsLoad(statistics: StatisticsInfo!) {
//        var dataEntries: [BarChartDataEntry] = []
//        let visitorCounts = getVisitorCountsFromDatabase()
//        for i in 0..<visitorCounts.count {
//            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(visitorCounts[i].count))
//            dataEntries.append(dataEntry)
//        }
//        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor count")
//        let chartData = BarChartData(dataSet: chartDataSet)
//        barView.data = chartData
    }
    
    internal func failedStatisticsLoad(error: ServerError!) {
    
    }
    
    internal func startLoader() {
    
    }
    
    internal func stopLoader() {
    
    }
}
