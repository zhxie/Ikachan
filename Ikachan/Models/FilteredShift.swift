//
//  FilteredShift.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/15.
//

import Foundation

struct FilteredShift: Hashable, Codable {
    var isFirst: Bool
    var status: String {
        if shift.stage == nil {
            return "future"
        } else {
            if isFirst {
                return shift.status
            } else {
                return "next"
            }
        }
    }
    
    var shift: Shift
}
