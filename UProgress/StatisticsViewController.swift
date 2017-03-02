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
    @IBOutlet weak var baseView: UIView!
    var pieChatViewController: PieChartViewController!
    var barChartViewController: BarChartViewController!
    var switchChartIcon: UIBarButtonItem!
    var pieChartDisplayed: Bool! = true
    var statisticsInfo: StatisticsInfo!
    
    @IBOutlet weak var pieChartView: UIView!
    @IBOutlet weak var barChartView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = StatisticsManager()
        let presenter = StatisticsPresenter(model: model, view: self)
        presenter.loadStatistics(userId: AuthorizationService.sharedInstance.currentUser.nick)
        
        var buttonsArr: [UIBarButtonItem]! = []
        switchChartIcon = customBarButtonItem(iconName: "bar_chart_icon", action: #selector(switchChartView(sender:)))
        buttonsArr.append(customBarButtonItem(iconName: "chart_type_icon", action: #selector(switchChartType(sender:))))
        buttonsArr.append(switchChartIcon)
        self.navigationItem.rightBarButtonItems = buttonsArr
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        barChartView.isHidden = true
    }
    
    func switchChartView(sender: UIBarButtonItem!) {
        pieChartDisplayed = !pieChartDisplayed
        var iconName: String!
        
        if pieChartDisplayed! {
            iconName = "bar_chart_icon"
        }
        else {
            iconName = "pie_chart_icon"
        }
        let button: UIButton = switchChartIcon.customView as! UIButton
        button.setImage(UIImage(named: iconName), for: .normal)
        switchChartIcon.customView = button
        displayStatistics()
    }
    
    func switchChartType(sender: UIBarButtonItem!) {
        displayStatistics()
    }
    
    internal func successStatisticsLoad(statistics: StatisticsInfo!) {
        self.statisticsInfo = statistics
        displayStatistics()
//        pieChatViewController.setData(statistics: statistics.directionSteps)
    }
    
    internal func failedStatisticsLoad(error: ServerError!) {
    
    }
    
    internal func startLoader() {
        
    }
    
    internal func stopLoader() {
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pieChart" {
            pieChatViewController = segue.destination as! PieChartViewController
        }
        
        if segue.identifier == "barChart" {
            barChartViewController = segue.destination as! BarChartViewController
        }
    }
    func customBarButtonItem(iconName: String!, action: Selector) -> UIBarButtonItem {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: iconName), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(switchChartView(sender:)), for: .touchUpInside)
        return UIBarButtonItem(customView: btn1)
    }
    private func displayStatistics() {
        if pieChartDisplayed! {
            barChartView.isHidden = true
            pieChartView.isHidden = false
            pieChatViewController.setData(statistics: statisticsInfo.directionSteps)
        }
        else {
            barChartView.isHidden = false
            pieChartView.isHidden = true
            barChartViewController.setData(statistics: statisticsInfo.directionSteps)
        }
    }
}
