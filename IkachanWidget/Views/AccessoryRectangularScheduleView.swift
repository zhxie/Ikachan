//
//  AccessoryRectangularScheduleView.swift
//  IkachanWidget
//
//  Created by Sketch on 2022/9/18.
//

import SwiftUI

struct AccessoryRectangularScheduleView: View {
    var schedule: Schedule?
    var mode: Mode?
    
    var body: some View {
        if let _ = mode {
            if let schedule = schedule {
                if #available(iOSApplicationExtension 16.0, *) {
                    HStack (alignment: .top) {
                        VStack (alignment: .leading, spacing: 0) {
                            HStack (spacing: 4) {
                                // TODO: Image should be replaced to SVG text.
                                Image(schedule.rule.image)
                                    .resizedToFit()
                                    .frame(width: 16, height: 16)
                                
                                Text(LocalizedStringKey(schedule.localizedShorterDescription))
                                    .font(.headline)
                                    .widgetAccentable()
                            }
                            
                            Text(LocalizedStringKey(schedule.stages[0].name))
                            Text(LocalizedStringKey(schedule.stages[1].name))
                        }
                        
                        Spacer()
                    }
                } else {
                    EmptyView()
                }
            } else {
                FailedToLoadView(accentColor: .white, transparent: true, error: .noSchedule)
            }
        } else {
            FailedToLoadView(accentColor: .white, transparent: true, error: .failedToLoad)
        }
    }
}

struct AccessoryRectangularScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        AccessoryRectangularScheduleView(schedule: SchedulePlaceholder, mode: Splatoon2ScheduleMode.regular)
    }
}
