//
//  LoadingViewController.swift
//  Open Data Project
//
//  Created by Yalishanda on 9.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    // MARK - Outlets
    
    @IBOutlet private weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK - Properties
    
    private let segueID = "begin"
    
    private var isLoading = true {
        didSet {
            isLoading ? loadingIndicator.startAnimating() : loadingIndicator.stopAnimating()
            loadingIndicator.isHidden = !isLoading
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

// MARK: - Helpers

private extension LoadingViewController {
    func loadData() {
        isLoading = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        DataRepository.shared.fetchAllStatisticalData { [weak self] success in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            guard let self = self else { return }
            
            self.isLoading = false
            
            if (success) {
                self.performSegue(withIdentifier: self.segueID, sender: self)
            }
        }
    }
}
