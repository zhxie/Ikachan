//
//  FilteredShift.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/15.
//

import Foundation

struct FilteredShift {
    var isFirst: Bool
    var status: String {
        if shift.stage == nil {
            return "future"
        } else {
            if isFirst {
                if shift.startTime < Date() {
                    return "open"
                } else {
                    return "soon"
                }
            } else {
                return "next"
            }
        }
    }
    
    var shift: Shift
}
