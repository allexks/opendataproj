//
//  StationDetailViewController.swift
//  Open Data Project
//
//  Created by Yalishanda on 6.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import UIKit
import AnyChartiOS

class StationDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var chartView: AnyChartView!
    
    // MARK: - Properties
    
    var pmType: PMType!
    var station: StationLocation!
    var stationViewModel: StationViewModel!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataNeeded()
        generateChart()
    }
}

// MARK: - Helpers

private extension StationDetailViewController {
    func fetchDataNeeded() {
        stationViewModel = DataRepository.shared.stationViewModel(for: station, pmType: pmType)
    }
    
    func generateChart() {
        let chart = AnyChart.line()
        
        chart.animation(settings: true)
        
        chart.padding(padding: [10, 20, 5, 20])
        
        chart.crosshair().enabled(enabled: true)
        chart.crosshair().yLabel(settings: true)
        
        chart.tooltip().positionMode(mode: .POINT)
        
        chart.title(settings: station.rawValue)
        
        chart.yAxis(index: 0).title(settings: "СД (µg/m3)")
        chart.xAxis(index: 0).labels().padding(padding: 5)
        
        let data = generateData()
        
        let set = anychart.data.Set().instantiate()
        set.data(data: data)
        let series1Mapping = set.mapAs(mapping: "{x: 'x', value: 'value'}")
        let series2Mapping = set.mapAs(mapping: "{x: 'x', value: 'value2'}")
        
        let series1 = chart.line(data: series1Mapping)
        series1.name(name: "Средно")
        series1.hovered().markers().enabled(enabled: true)
        series1.hovered().markers()
            .type(type: .CIRCLE)
            .size(size: 4)
        series1.tooltip()
            .position(position: "right")
            .anchor(anchor: .LEFT_CENTER)
            .offsetX(offset: 5)
            .offsetY(offset: 5)
        
        let series2 = chart.line(data: series2Mapping)
        series2.name(name: "Максимално")
        series2.hovered().markers().enabled(enabled: true)
        series2.hovered().markers()
            .type(type: .CIRCLE)
            .size(size: 4)
        series2.tooltip()
            .position(position: "right")
            .anchor(anchor: .LEFT_CENTER)
            .offsetX(offset: 5)
            .offsetY(offset: 5)
        
        chart.legend().enabled(enabled: true)
        chart.legend().fontSize(size: 13)
        chart.legend().padding(padding: [0, 0, 10, 0])
        
        chartView.setChart(chart: chart)
    }
    
    func generateData() -> [DataEntry] {
        var result: [DataEntry] = []
        for datapoint in stationViewModel.dataPoints {
            result.append(CustomDataEntry(
                x: datapoint.period,
                value: datapoint.avgValue,
                value2: datapoint.maxValue
            ))
        }
        return result
    }
    
    class CustomDataEntry: ValueDataEntry {
        init(x: String, value: Double, value2: Double) {
            super.init(x: x, value: value)
            setValue(key: "value2", value: value2)
        }
    }
}
