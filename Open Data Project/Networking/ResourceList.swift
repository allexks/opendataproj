//
//  ResourceList.swift
//  Open Data Project
//
//  Created by Yalishanda on 3.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation

struct ResourceList: Decodable {
    let resources: [ResourceMetadata]
    let total_records: Int
}
