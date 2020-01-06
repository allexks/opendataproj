//
//  StationsViewController.swift
//  Open Data Project
//
//  Created by Yalishanda on 4.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import MapKit

class StationsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    let stationCellReuseID = "stationCell"
    
    var pmType: PMType!
    
    var annotations: [MKAnnotation] = [] {
        didSet {
            mapView.addAnnotations(annotations)
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        mapView.delegate = self

        addAnnotationsForAllLocations()
    }
}

// MARK: - Helpers

private extension StationsViewController {
    func addAnnotationsForAllLocations() {
        let locations = DataRepository.shared.allLocations(forPmType: pmType)
        annotations = locations.map { StationAnnotation($0) }
    }
}

// MARK: - Table View Data Source

extension StationsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mapView.annotations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: stationCellReuseID,
            for: indexPath
        )
        let item = mapView.annotations[indexPath.row]
        cell.textLabel?.text = item.title ?? ""
        return cell
    }
}

// MARK: - Table View Delegate

extension StationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedAnnotation = mapView.annotations[indexPath.row]
        mapView.selectAnnotation(selectedAnnotation, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let deselectedAnnotation = mapView.annotations[indexPath.row]
        mapView.deselectAnnotation(deselectedAnnotation, animated: true)
    }
}

// MARK: - Map View Delegate

extension StationsViewController: MKMapViewDelegate {
    // TODO: show nice accessory and button to next ViewController
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation,
            let index = mapView.annotations.firstIndex(where: { $0 === annotation })
        else {
            return
        }
        
        let correspondingCellIndexPath = IndexPath(row: index, section: 0)
        let selectedIndexPath = tableView.indexPathForSelectedRow
        if selectedIndexPath == nil || selectedIndexPath! != correspondingCellIndexPath {
            tableView.selectRow(at: correspondingCellIndexPath, animated: true, scrollPosition: .middle)
        }
        
    }
}
