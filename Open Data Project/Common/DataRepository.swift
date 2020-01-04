//
//  DataRepository.swift
//  Open Data Project
//
//  Created by Yalishanda on 4.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation

class DataRepository {
    static let shared = DataRepository()
    private init() {
        wholePeriodTables = [:]
        smallPeriodTables = [:]
        
        for pm in PMType.allCases {
            wholePeriodTables[pm] = []
            smallPeriodTables[pm] = []
        }
    }
    
    private static let apiService = OpenDataAPIService()
    
    private var wholePeriodTables: [PMType: [DataTable]]
    private var smallPeriodTables: [PMType: [DataTable]]
    
    func fetchAllStatisticalData(_ completion: ((_ success: Bool) -> Void)?) {
        DataRepository.apiService.getDataSetResources { list in
            guard let list = list else {
                completion?(false)
                return
            }
            
            let group = DispatchGroup()
            
            list.resources.forEach { resourceMetadata in
                group.enter()
                DataRepository.apiService.getResourceData(resourceMetadata.uri, completion: {
                    resourceFetchedData in
                    
                    guard let resourceData = resourceFetchedData else {
                        completion?(false)
                        group.leave()
                        return
                    }
                    
                    let dataTable = resourceData.toDataTable(
                        guid: resourceMetadata.uri,
                        name: resourceMetadata.name
                    )
                    
                    if dataTable.dataCollectedFrom == nil && dataTable.dataCollectedTo == nil {
                        self.wholePeriodTables[dataTable.pmType]?.append(dataTable)
                    } else {
                        self.smallPeriodTables[dataTable.pmType]?.append(dataTable)
                    }
                    
                    group.leave()
                })
            }
            
            group.notify(queue: .main, execute: {
                completion?(true)
                print(self)
            })
        }
    }
}

extension ResourceData {
    fileprivate var dateFormatter: DateFormatter {
        let result = DateFormatter()
        result.timeZone = TimeZone(secondsFromGMT: 0)
        result.dateStyle = .long
        result.timeStyle = .none
        result.dateFormat = "dd.MM.yyyy"
        return result
    }
    
    func toDataTable(guid: String, name: String) -> DataTable {
        guard let pmTypeString = name.matches("(10|2.5)( )?µm").first,
            let pmType = PMType.init(rawValue: pmTypeString.starts(with: "10") ?  "10" : "2.5")
        else {
            fatalError("ERROR: No PM Type found from name '\(name)'")
        }
        
        var fromDate: Date?
        var toDate: Date?
        
        let dateStrings = name.matches("[0-9][0-9]\\.[0-9][0-9]\\.[0-9][0-9][0-9][0-9]")
        if dateStrings.count == 2 {
            let dates = dateStrings.map { dateFormatter.date(from: $0)! }.sorted(by: <)
            fromDate = dates[0]
            toDate = dates[1]
        }

        let columnNames = self.data[1]
        
        let rows = self.data[2...].map { row in
            DataTable.Row(
                location: StationLocation(row[0]),
                valuesCount: Int(row[1]) ?? 0,
                exceedancesCount: row.count == 5 ? Int(row[2]) : nil,
                maxValue: Double(row[row.count == 5 ? 3 : 2]) ?? 0.0,
                avgValue: Double(row[row.count == 5 ? 4 : 3]) ?? 0.0
            )
        }
        
        return DataTable (
            guid: guid,
            name: name,
            pmType: pmType,
            dataCollectedFrom: fromDate,
            dataCollectedTo: toDate,
            columnNames: columnNames,
            rows: rows
        )
    }
}
