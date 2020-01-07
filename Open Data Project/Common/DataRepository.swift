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
    
    static let yearOnlyDateFormatter: DateFormatter = {
        var result = DateFormatter()
        result.dateFormat = "yyyy"
        result.dateStyle = .short
        result.timeStyle = .none
        result.timeZone = TimeZone(secondsFromGMT: 0)
        return result
    }()
    
    let wholePeriodFromDate = Date(timeIntervalSince1970: 1104537600) // 1 Jan 2005
    let wholePeriodToDate = Date(timeIntervalSince1970: 1546214400) // 31 Dec 2018
    
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
    
    func allLocations(forPmType pmType: PMType) -> [StationLocation] {
        var result: Set<StationLocation> = []
        for table in smallPeriodTables[pmType] ?? [] {
            for row in table.rows {
                result.update(with: row.location)
            }
        }
        return Array(result)
    }
    
    func fetchAllPeriodViewModels(forPmType pmType: PMType) -> [PeriodViewModel] {
        return ((wholePeriodTables[pmType] ?? []) + (smallPeriodTables[pmType] ?? [])).map {
            $0.toPeriodViewModel()
        }.sorted {
            $0.dateFrom < $1.dateFrom
        }
    }
    
    func stationViewModel(for station: StationLocation, pmType: PMType) -> StationViewModel {
        let result = StationViewModel(station: station, dataPoints: [])
        for period in smallPeriodTables[pmType] ?? [] {
            guard let row = period.rows.first(where: { $0.location == station }) else {
                continue
            }
            guard let dateFrom = period.dataCollectedFrom,
                let dateTo = period.dataCollectedTo else {
                continue
            }
            
            let formatter = DataRepository.yearOnlyDateFormatter
            let yearFrom = formatter.string(from: dateFrom)
            let yearTo = formatter.string(from: dateTo)
            
            if (yearFrom == yearTo) {
                result.dataPoints.append(row.toDataPoint(for: yearFrom))
            }
        }
        return result
    }
}

extension ResourceData {
    func toDataTable(guid: String, name: String) -> DataTable {
        guard let pmTypeString = name.matches("(10|2.5)( )?µm").first,
            let pmType = PMType.init(rawValue: pmTypeString.starts(with: "10") ?  "10" : "2.5")
        else {
            fatalError("ERROR: No PM Type found from name '\(name)'")
        }
        
        var fromDate: Date?
        var toDate: Date?
        
        let dateStrings = name.matches("[0-9][0-9]\\.[0-9][0-9]\\.[0-9][0-9][0-9][0-9]")
        let dateFormatter = PeriodViewModel.dateFormatter
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

extension DataTable {
    func toPeriodViewModel() -> PeriodViewModel {
        guard let from = dataCollectedFrom, let to = dataCollectedTo else {
            return PeriodViewModel(
                dateFrom: DataRepository.shared.wholePeriodFromDate,
                dateTo: DataRepository.shared.wholePeriodToDate,
                relatedDataTable: self,
                isSumOfAllPeriods: true
            )
        }
        
        return PeriodViewModel(dateFrom: from, dateTo: to, relatedDataTable: self, isSumOfAllPeriods: false)
    }
}

extension DataTable.Row {
    func toDataPoint(for year: String) -> StationViewModel.DataPoint {
        return StationViewModel.DataPoint(year: year, avgValue: avgValue, maxValue: maxValue)
    }
}
