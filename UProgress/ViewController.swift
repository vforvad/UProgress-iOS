//
//  ViewController.swift
//  UProgress
//
//  Created by Vadim Sokoltsov on 28.01.17.
//  Copyright © 2017 vsokoltsov. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DirectionViewProtocol {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var itemsList:[String] = ["1", "2", "3", "4", "5"]
    var url = "http://192.168.99.100:3000/api/v1/users/vforvad/directions"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var headers = [
            "Content-Type": "application/json",
        ]
        
        Alamofire.request(url, method: .get)
            .responseArray(keyPath: "directions") { (response: DataResponse<[Direction]>) in
                switch(response.result) {
                case .success(let value):
                    print(value)
                case .failure(let errorValue):
                    print(errorValue)
                }
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        return itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellId")
        cell.textLabel?.text = itemsList[indexPath.row]
        return cell
    }

    internal func successDirectionsLoad(directions: [Direction]!) {
        
    }
    
    internal func stopLoader() {
        
    }
    
    internal func startLoader() {
        
    }
    
    internal func failedDirectionsLoad(error: NSError) {
        
    }
}

