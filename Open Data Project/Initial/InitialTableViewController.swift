//
//  InitialTableViewController.swift
//  Open Data Project
//
//  Created by Yalishanda on 3.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import UIKit

class InitialTableViewController: UITableViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        DataRepository.shared.fetchAllStatisticalData { _ in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            // TODO: Handle error
        }
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextVC = segue.destination as? GroupingTableViewController else {
            fatalError("brat ne e toz ViewController-a")
        }
        
        switch segue.identifier {
        case "pm25":
            nextVC.pmType = .pm25
        case "pm10":
            nextVC.pmType = .pm10
        default:
            fatalError("brat zako pipash imeto na segue-to sq")
        }
    }
}
