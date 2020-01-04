//
//  InitialViewModel.swift
//  Open Data Project
//
//  Created by Yalishanda on 4.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation

class InitialViewModel {
    
    var onLoadingStateChanged: (() -> Void)?
    private(set) var isLoading = false {
        didSet {
            onLoadingStateChanged?()
        }
    }
    
    func onViewDidLoad() {
        isLoading = true
        DataRepository.shared.fetchAllStatisticalData { _ in
            self.isLoading = false
        }
    }
}
