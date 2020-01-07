//
//  StationViewModel.swift
//  Open Data Project
//
//  Created by Aleksandar Ignatov on 7.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation

class StationViewModel {
    let station: StationLocation
    var dataPoints: [DataPoint]
    
    init(station: StationLocation, dataPoints: [DataPoint]) {
        self.station = station
        self.dataPoints = dataPoints
    }
}

extension StationViewModel {
    struct DataPoint {
        let year: String
        let avgValue: Double
        let maxValue: Double
    }
}
