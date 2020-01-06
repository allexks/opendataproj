//
//  PeriodViewModel.swift
//  Open Data Project
//
//  Created by Aleksandar Ignatov on 6.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation

class PeriodViewModel {
    static var dateFormatter: DateFormatter = {
        let result = DateFormatter()
        result.timeZone = TimeZone(secondsFromGMT: 0)
        result.dateStyle = .long
        result.timeStyle = .none
        result.dateFormat = "dd.MM.yyyy"
        return result
    }()
    
    let dateFrom: Date
    let dateTo: Date
    let isSumOfAllPeriods: Bool
    
    init(dateFrom: Date, dateTo: Date, isSumOfAllPeriods: Bool = false) {
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.isSumOfAllPeriods = isSumOfAllPeriods
    }
    
    var stringFrom: String {
        return PeriodViewModel.dateFormatter.string(from: dateFrom)
    }
    
    var stringTo: String {
        return PeriodViewModel.dateFormatter.string(from: dateTo)
    }
    
    var asString: String {
        return isSumOfAllPeriods ? "Всички години (2005-2018)" : "\(stringFrom) – \(stringTo)"
        // TODO: Don't hardcode 2005-2018
    }
}
