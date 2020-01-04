//
//  InitialTableViewController.swift
//  Open Data Project
//
//  Created by Yalishanda on 3.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import UIKit

class InitialTableViewController: UITableViewController {
    
    let viewModel = InitialViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        viewModel.onViewDidLoad()
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

private extension InitialTableViewController {
    func setupViewModel() {
        viewModel.onLoadingStateChanged = { [weak self] in
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = self?.viewModel.isLoading ?? false
            }
        }
    }
}
