//
//  PeriodDetailViewController.swift
//  Open Data Project
//
//  Created by Aleksandar Ignatov on 6.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import UIKit

class PeriodDetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var periodViewModel: PeriodViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(periodViewModel.asString) // DEBUG
        // TODO: Draw some charts!
    }

}
