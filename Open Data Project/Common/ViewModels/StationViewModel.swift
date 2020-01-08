//
//  StationViewModel.swift
//  Open Data Project
//
//  Created by Aleksandar Ignatov on 7.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation

class StationViewModel {
    static let monthFormatter: DateFormatter = {
        var result = DateFormatter()
        result.dateFormat = "LLLL"
        result.timeZone = TimeZone(secondsFromGMT: 0)
        return result
    }()
    
    static let yearFormatter: DateFormatter = {
        var result = DateFormatter()
        result.dateFormat = "yyyy"
        result.timeZone = TimeZone(secondsFromGMT: 0)
        return result
    }()
    
    let station: StationLocation
    var dataPoints: [DataPoint]
    
    init(station: StationLocation, dataPoints: [DataPoint]) {
        self.station = station
        self.dataPoints = dataPoints
    }
}

extension StationViewModel {
    struct DataPoint {
        let periodStart: Date
        let periodEnd: Date
        let avgValue: Double
        let maxValue: Double
        
        var period: String {
            let yearFormatter = StationViewModel.yearFormatter
            let monthFormatter = StationViewModel.monthFormatter
            return "\(monthFormatter.string(from: periodStart)) - \(monthFormatter.string(from: periodEnd)) \(yearFormatter.string(from: periodEnd))"
        }
    }
}
