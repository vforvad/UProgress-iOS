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
    var pieChart: PieChartView!
    var pieChatViewController: PieChartViewController!
    var switchChartIcon: UIBarButtonItem!
    var pieChartDisplayed: Bool! = true
    
    @IBOutlet weak var pieChartView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let model = StatisticsManager()
        let presenter = StatisticsPresenter(model: model, view: self)
        presenter.loadStatistics(userId: AuthorizationService.sharedInstance.currentUser.nick)
        
        var buttonsArr: [UIBarButtonItem]! = []
        switchChartIcon = customBarButtonItem(iconName: "pie_chart_icon", action: #selector(switchChartView(sender:)))
        buttonsArr.append(customBarButtonItem(iconName: "chart_type_icon", action: #selector(switchChartType(sender:))))
        buttonsArr.append(switchChartIcon)
        self.navigationItem.rightBarButtonItems = buttonsArr
    }
    
    func switchChartView(sender: UIBarButtonItem!) {
        pieChartDisplayed = !pieChartDisplayed
        var iconName: String!
        
        if pieChartDisplayed! {
            iconName = "pie_chart_icon"
        }
        else {
            iconName = "bar_chart_icon"
        }
        let button: UIButton = switchChartIcon.customView as! UIButton
        button.setImage(UIImage(named: iconName), for: .normal)
        switchChartIcon.customView = button
    }
    
    func switchChartType(sender: UIBarButtonItem!) {
        
    }
    
    internal func successStatisticsLoad(statistics: StatisticsInfo!) {
        pieChatViewController.setData(statistics: statistics.directionSteps)
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
    }
    func customBarButtonItem(iconName: String!, action: Selector) -> UIBarButtonItem {
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: iconName), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(switchChartView(sender:)), for: .touchUpInside)
        return UIBarButtonItem(customView: btn1)
    }
}
