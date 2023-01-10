//
//  AccessoryCircularShiftView.swift
//  IkachanWidget
//
//  Created by Sketch on 2022/9/18.
//

import SwiftUI

struct AccessoryCircularShiftView: View {
    let current: Date
    let shift: Shift?
    let mode: Mode
    
    var body: some View {
        AccessoryCircularBaseView(value: percent, image: shift?.rule.image ?? "inkling_splatted", text: mode.shorterName)
    }
    
    var percent: Double {
        guard let shift = shift else {
            return 0
        }
        
        let current = current - shift.startTime
        let total = shift.endTime - shift.startTime
        return min(max(current / total, 0), 1)
    }
}

struct AccessoryCircularShiftView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryCircularShiftView(current: Date(), shift: ShiftPlaceholder, mode: Splatoon2ShiftMode.salmonRun)
    }
}
