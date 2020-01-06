//
//  StationAnnotation.swift
//  Open Data Project
//
//  Created by Yalishanda on 6.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import MapKit

class StationAnnotation: NSObject, MKAnnotation {
    
    let station: StationLocation
    
    init(_ station: StationLocation) {
        self.station = station
        super.init()
    }
    
    var coordinate: CLLocationCoordinate2D {
        return station.location.coordinate
    }
    
    var title: String? {
        return station.rawValue
    }
}
