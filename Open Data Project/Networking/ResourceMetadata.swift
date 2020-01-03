//
//  ResourceMetadata.swift
//  Open Data Project
//
//  Created by Yalishanda on 3.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation

struct ResourceMetadata: Decodable {
    let id: Int
    let uri: String
    let dataset_uri: String
    let name: String
}
