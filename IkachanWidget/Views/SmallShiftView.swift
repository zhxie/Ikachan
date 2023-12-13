//
//  SmallShiftView.swift
//  IkachanWidget
//
//  Created by Sketch on 2023/12/13.
//

import SwiftUI
import WidgetKit

struct SmallShiftView: View {
    var shift: Shift?
    
    var body: some View {
        if let shift = shift {
            VStack(spacing: 8) {
                HStack(alignment: .center) {
                    Image(shift.mode.image)
                        .resizedToFit()
                        .frame(width: 16, height: 16)
                        .layoutPriority(1)
                    Text(LocalizedStringKey(shift.mode.name))
                        .fontWeight(.bold)
                        .foregroundColor(shift.mode.accentColor)
                        .lineLimit(1)
                    
                    Spacer()
                }
                .layoutPriority(1)
                
                if let stage = shift.stage {
                    StageView(stage: stage)
                    
                    HStack {
                        ForEach(shift.weapons!, id: \.name) { weapon in
                            WeaponView(weapon: weapon)
                        }
                    }
                    .layoutPriority(1)
                }
            }
        } else {
            Text(LocalizedStringKey("no_shift"))
        }
    }
}

@available(iOSApplicationExtension 17.0, *)
struct SmallShift_Previews: PreviewProvider {
    static var previews: some View {
        SmallShiftView(shift: PreviewSplatoon2Shift)
            .containerBackground(for: .widget, content: {})
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
