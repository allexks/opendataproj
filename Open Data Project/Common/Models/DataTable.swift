//
//  DataTable.swift
//  Open Data Project
//
//  Created by Yalishanda on 4.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation

struct DataTable {
    let guid: String
    let name: String
    let pmType: PMType
    let dataCollectedFrom: Date?
    let dataCollectedTo: Date?
    let columnNames: [String]
    let rows: [Row]
}

extension DataTable {
    struct Row {
        let location: StationLocation
        let valuesCount: Int
        let exceedancesCount: Int?
        let maxValue: Double
        let avgValue: Double
    }
}
