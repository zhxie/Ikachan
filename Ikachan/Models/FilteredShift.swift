//
//  FilteredShift.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/15.
//

import SwiftUI

struct FilteredShift: Hashable, Codable {
    var isFirst: Bool
    var status: LocalizedStringKey {
        if shift.stage == nil {
            return LocalizedStringKey("future")
        } else {
            if isFirst {
                return shift.status
            } else {
                return LocalizedStringKey("next")
            }
        }
    }
    
    var shift: Shift
}
