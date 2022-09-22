//
//  AccessoryRectangularShiftView.swift
//  IkachanWidget
//
//  Created by Sketch on 2022/9/22.
//

import SwiftUI

struct AccessoryRectangularShiftView: View {
    var shift: Shift?
    
    var body: some View {
        if let shift = shift {
            if #available(iOSApplicationExtension 16.0, *) {
                HStack (alignment: .top) {
                    VStack (alignment: .leading, spacing: 0) {
                        HStack (spacing: 4) {
                            // TODO: Image should be replaced to SVG text.
                            Image(shift.mode.image)
                                .resizedToFit()
                                .frame(width: 16, height: 16)
                            
                            Text(LocalizedStringKey(shift.stage!.name))
                                .font(.headline)
                                .widgetAccentable()
                        }
                        
                        HStack (spacing: 4) {
                            WeaponView(weapon: shift.weapons[0])
                            WeaponView(weapon: shift.weapons[1])
                            WeaponView(weapon: shift.weapons[2])
                            WeaponView(weapon: shift.weapons[3])
                        }
                    }
                    
                    Spacer()
                }
            } else {
                EmptyView()
            }
        } else {
            FailedToLoadView(accentColor: .white, transparent: true)
        }
    }
}

struct AccessoryRectangularShiftView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryRectangularShiftView(shift: ShiftPlaceholder)
    }
}
