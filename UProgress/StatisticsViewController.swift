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
import CDAlertView

class StatisticsViewController: BaseViewController, StatisticsViewProtocol {
    @IBOutlet weak var baseView: UIView!
    var pieChatViewController: PieChartViewController!
    var barChartViewController: BarChartViewController!
    var switchChartIcon: UIBarButtonItem!
    var pieChartDisplayed: Bool! = true
    var statisticsInfo: StatisticsInfo!
    private let imagePicker = UIImagePickerController()
    private var scopeId: String! = "directions"
    
    
    @IBOutlet weak var pieChartView: UIView!
    @IBOutlet weak var barChartView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setColoredTitle(title: NSLocalizedString("statistics_title_page", comment: ""))
        let model = StatisticsManager()
        let presenter = StatisticsPresenter(model: model, view: self)
        presenter.loadStatistics(userId: AuthorizationService.sharedInstance.currentUser.nick)
        
        var buttonsArr: [UIBarButtonItem]! = []
        switchChartIcon = CommonFunctions.barButtonAsButton(target: self, iconName: "bar_chart_icon", action: #selector(switchChartView(_:)))
        buttonsArr.append(CommonFunctions.barButtonAsButton(target: self, iconName: "chart_type_icon", action: #selector(switchChartType(_:))))
        buttonsArr.append(switchChartIcon)
        self.navigationItem.rightBarButtonItems = buttonsArr
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        barChartView.isHidden = true
    }
    
    func switchChartView(_ sender: UIButton!) {
        pieChartDisplayed = !pieChartDisplayed
        var iconName: String!
        
        if pieChartDisplayed! {
            iconName = "bar_chart_icon"
        }
        else {
            iconName = "pie_chart_icon"
        }
        sender.setImage(UIImage(named: iconName), for: UIControlState.normal)
        displayStatistics()
    }
    
    func switchChartType(_ sender: UIButton!) {
         let alert:UIAlertController = UIAlertController(title: NSLocalizedString("statistics_title", comment: ""), message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let directionsAction = UIAlertAction(title: NSLocalizedString("statistics_directions", comment: ""), style: UIAlertActionStyle.default) { UIAlertAction in
            self.scopeId = "directions"
            self.displayStatistics()
        }
        
        let stepsActions = UIAlertAction(title: NSLocalizedString("statistics_steps", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.scopeId = "steps"
            self.displayStatistics()
        }
        
        let directionsSteps = UIAlertAction(title: NSLocalizedString("statistics_directions_steps", comment: ""), style: UIAlertActionStyle.default) {
            UIAlertAction in
            self.scopeId = "directionsSteps"
            self.displayStatistics()
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("profile_image_cancel", comment: ""), style: UIAlertActionStyle.cancel) { UIAlertAction in
        }
        
        alert.addAction(directionsAction)
        alert.addAction(stepsActions)
        alert.addAction(directionsSteps)
        alert.addAction(cancelAction)
        alert.popoverPresentationController?.sourceView = sender
        alert.popoverPresentationController?.sourceRect = sender.bounds
        present(alert, animated: true, completion: {})
        
    }
    
    internal func successStatisticsLoad(statistics: StatisticsInfo!) {
        self.statisticsInfo = statistics
        displayStatistics()
    }
    
    internal func failedStatisticsLoad(error: ServerError!) {
        CDAlertView(title: NSLocalizedString("error_title", comment: ""),
                    message: NSLocalizedString("server_not_respond", comment: ""), type: .error).show()
    }
    
    internal func startLoader() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }
    
    internal func stopLoader() {
        MBProgressHUD.hide(for: view, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pieChart" {
            pieChatViewController = segue.destination as! PieChartViewController
        }
        
        if segue.identifier == "barChart" {
            barChartViewController = segue.destination as! BarChartViewController
        }
    }
    
    private func displayStatistics() {
        if pieChartDisplayed! {
            barChartView.isHidden = true
            pieChartView.isHidden = false
            pieChatViewController.setData(statistics: getScope(statistics: statisticsInfo))
        }
        else {
            barChartView.isHidden = false
            pieChartView.isHidden = true
            barChartViewController.setData(statistics: getScope(statistics: statisticsInfo))
        }
    }
    
    private func getScope(statistics: StatisticsInfo!) -> [StatisticsItem]! {
        switch(self.scopeId) {
        case "directions":
            return statistics.directions
        case "steps":
            return statistics.steps
        case "directionsSteps":
            return statistics.directionSteps
        default:
            return statistics.directions
        }
    }
    
    
}
