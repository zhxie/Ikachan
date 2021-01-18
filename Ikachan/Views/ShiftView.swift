//
//  ShiftView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/17.
//

import SwiftUI

struct ShiftView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                VStack(spacing: 15) {
                    if details.count > 0 {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(status(startTime: details[0].startTime, endTime: details[0].endTime))
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                Text(title(startTime: details[0].startTime))
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                            
                            Image("salmon_run")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal)
                        
                        XCardView(image: String(format: "%@%@", Splatnet2URL, details[0].stage!.image.rawValue), title: details[0].stage!.description, subimages: mapWeaponImage(weapons: details[0].weapons))
                        
                        if details.count > 1 || schedules.count > 0 {
                            Spacer()
                                .frame(height: 45)
                        }
                    }
                }
                
                VStack(spacing: 15) {
                    if details.count > 1 {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(status(startTime: details[1].startTime, endTime: details[1].endTime))
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.secondary)
                                Text("next")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                            
                            Image("salmon_run")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal)
                        
                        XCardView(image: String(format: "%@%@", Splatnet2URL, details[1].stage!.image.rawValue), title: details[1].stage!.description, subimages: mapWeaponImage(weapons: details[1].weapons))
                        
                        if schedules.count > 0 {
                            Spacer()
                                .frame(height: 45)
                        }
                    }
                }
                
                VStack(spacing: 15) {
                    if schedules.count > 0 {
                        HStack {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("future")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                    .lineLimit(1)
                            }
                            .layoutPriority(1)
                            
                            Spacer()
                            
                            Image("salmon_run")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal)
                        
                        ForEach(schedules, id: \.self) { shift in
                            SCardView(title: status(startTime: shift.startTime, endTime: shift.endTime))
                        }
                    }
                }
            }
            .padding(.vertical)
        }
        .onAppear(perform: update)
    }
    
    var details: [Shift] {
        modelData.shifts.filter { shift in
            shift.stage != nil
        }
    }

    var schedules: [Shift] {
        modelData.shifts.filter { shift in
            shift.stage == nil
        }
    }
    
    func status(startTime: Date, endTime: Date) -> String {
        let current = Date()
        
        if startTime < current {
            return timeDescription(startTime: startTime, endTime: endTime)
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/DD HH:mm"
            
            let startTime = dateFormatter.string(from: startTime)
            let endTime = dateFormatter.string(from: endTime)
            
            return String(format: "%@ - %@", startTime, endTime)
        }
    }
    
    func title(startTime: Date) -> String {
        let current = Date()
        
        if startTime < current {
            return "open"
        } else {
            return "soon"
        }
    }
    
    func mapWeaponImage(weapons: [Weapon]) -> [String] {
        var result: [String] = []
        
        for weapon in weapons {
            result.append(String(format: "%@%@", Splatnet2URL, weapon.image))
        }
        
        return result
    }
    
    func update() {
        modelData.updateShifts()
    }
}

struct ShiftView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "shifts", bundle: Bundle.main)!
        
        _ = modelData.loadShifts(data: asset.data)
        
        return ShiftView()
            .environmentObject(modelData)
    }
}
