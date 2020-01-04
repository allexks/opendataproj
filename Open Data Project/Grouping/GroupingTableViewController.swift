//
//  GroupingTableViewController.swift
//  Open Data Project
//
//  Created by Yalishanda on 4.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import UIKit

class GroupingTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    var pmType: PMType!

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.destination {
        case let stations as StationsViewController:
            stations.pmType = pmType
        case let periods as PeriodsViewController:
            periods.pmType = pmType
        default:
            fatalError("smenili sme viewcontrollerchetata mai")
        }
    }
}
