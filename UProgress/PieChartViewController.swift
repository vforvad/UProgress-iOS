//
//  PieChartViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 01.03.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import Foundation
import UIKit
import Charts
import UIColor_Hex_Swift

class PieChartViewController: UIViewController {
    @IBOutlet var pieChart: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setData(statistics: [StatisticsItem]!) {
        var dataEntries: [PieChartDataEntry] = []
        var colors: [NSUIColor] = []
        for var i in (0..<statistics.count) {
            var dataEntry: PieChartDataEntry!
            let item: StatisticsItem! = statistics[i]
            if item.value != nil {
                dataEntry = PieChartDataEntry(value: item.value, label: item.label)
                dataEntries.append(dataEntry)
            }
            colors.append(UIColor(item.color))
            
        }
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "")
        chartDataSet.setColors(colors, alpha: 1.0)
        let chartData = PieChartData(dataSet: chartDataSet)
        pieChart.data = chartData
        pieChart.animate(xAxisDuration: 0.5, yAxisDuration: 0.5)
    }
}
