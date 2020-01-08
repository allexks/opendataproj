//
//  InitialTableViewController.swift
//  Open Data Project
//
//  Created by Yalishanda on 3.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import UIKit

class InitialTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private lazy var loadingIndicatorView: UIView = {
        let result = UIView()
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        result.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: result.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: result.centerYAnchor).isActive = true
        indicator.widthAnchor.constraint(equalTo: result.widthAnchor).isActive = true
        indicator.heightAnchor.constraint(equalTo: result.heightAnchor).isActive = true
        return result
    }()
    
    private var isLoading: Bool = true {
        didSet {
            loadingIndicatorView.isHidden = !isLoading
            tableView.isHidden = isLoading
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loadingIndicatorView)
        loadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadingIndicatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        loadingIndicatorView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
        loadData()
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

private extension InitialTableViewController {
    func loadData() {
        isLoading = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        DataRepository.shared.fetchAllStatisticalData { [weak self] _ in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self?.isLoading = false
        }
    }
}
