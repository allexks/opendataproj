//
//  PeriodDetailViewController.swift
//  Open Data Project
//
//  Created by Aleksandar Ignatov on 6.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import UIKit
import AnyChartiOS

class PeriodDetailViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var chartView: AnyChartView!
    
    // MARK: - Properties
    
    var periodViewModel: PeriodViewModel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateChart()
    }
}

// MARK: - Helpers

private extension PeriodDetailViewController {
    func generateChart() {
        let chart = AnyChart.vertical()
        
        chart.animation(settings: true)
            .title(settings: periodViewModel.asString)
        
        let data = generateChartData()
        
        let set = anychart.data.Set().instantiate()
        set.data(data: data)
        let barData = set.mapAs(mapping: "{x: 'x', value: 'value'}")
        let jumpLineData = set.mapAs(mapping: "{x: 'x', value: 'jumpLine'}")
        
        let bar = chart.bar(data: barData)
        bar.labels().format(token: "{%Value}{decimalsCount:2} µg/m3")
        
        let jumpLine = chart.jumpLine(data: jumpLineData)
        jumpLine.stroke(settings: "2 #60727B")
        jumpLine.labels().enabled(enabled: false)
        
        chart.yScale().minimum(minimum: 0)
        
        chart.labels(settings: true)
        
        chart.tooltip()
            .displayMode(value: .UNION)
            .positionMode(mode: .POINT)
        
        chart.interactivity().hoverMode(mode: anychart.enums.HoverMode.BY_X)
        
        chart.xAxis(settings: true)
        chart.yAxis(settings: true)
        chart.yAxis(index: 0).labels().format(token: "{%Value}")
        
        chartView.setChart(chart: chart)
    }
    
    func generateChartData() -> [DataEntry] {
        var result: [DataEntry] = []
        for row in periodViewModel.relatedDataTable.rows {
            result.append(CustomDataEntry(
                x: row.location.rawValue,
                value: row.maxValue,
                jumpLine: row.avgValue
            ))
        }
        return result
    }
    
    class CustomDataEntry: ValueDataEntry {
        init(x: String, value: Double, jumpLine: Double) {
            super.init(x: x, value: value)
            setValue(key: "jumpLine", value: jumpLine)
        }
    }
}
