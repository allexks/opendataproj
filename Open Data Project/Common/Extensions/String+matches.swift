//
//  String+matches.swift
//  Open Data Project
//
//  Created by Yalishanda on 4.01.20.
//  Copyright © 2020 fmi-swift. All rights reserved.
//

import Foundation

extension String {
    func matches(_ regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(
                in: self,
                range: NSRange(self.startIndex..., in: self)
            )
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("ERROR: Invalid regex '\(regex)' for word \(self): \(error.localizedDescription)")
            return []
        }
    }
}
