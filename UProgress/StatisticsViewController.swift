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
import Charts
import UIColor_Hex_Swift

class StatisticsViewController: BaseViewController, StatisticsViewProtocol {
    @IBOutlet weak var pieChart: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = StatisticsManager()
        let presenter = StatisticsPresenter(model: model, view: self)
        presenter.loadStatistics(userId: AuthorizationService.sharedInstance.currentUser.nick)
    }
    
    internal func successStatisticsLoad(statistics: StatisticsInfo!) {
        var dataEntries: [PieChartDataEntry] = []
        var colors: [NSUIColor] = []
        for var i in (0..<statistics.directionSteps.count) {
            let item: StatisticsItem! = statistics.directionSteps[i]
            let dataEntry = PieChartDataEntry(value: item.value, label: item.label)
            dataEntries.append(dataEntry)
            colors.append(UIColor(item.color))
            
        }
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "Test")
        chartDataSet.setColors(colors, alpha: 1.0)
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChart.data = chartData
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
