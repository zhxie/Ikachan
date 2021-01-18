//
//  ShiftsView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct ShiftsView: View {
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let first = current {
                        Divider()
                            .padding(.horizontal)
                        
                        ShiftView(shift: first, title: title(startTime: first.startTime))
                        
                        Spacer()
                            .frame(height: 15)
                    }
                    
                    ForEach(nexts, id: \.self) { shift in
                        Divider()
                            .padding(.horizontal)
                        
                        ShiftView(shift: shift, title: "next")
                        
                        Spacer()
                            .frame(height: 15)
                    }
                    
                    ForEach(schedules, id: \.self) { shift in
                        Divider()
                            .padding(.horizontal)
                        
                        ShiftView(shift: shift, title: "future")
                        
                        Spacer()
                            .frame(height: 15)
                    }
                }
                .padding(.vertical)
                .navigationTitle("salmon_run")
            }
        }
        .onAppear(perform: update)
    }
    
    var details: [Shift] {
        modelData.shifts.filter { shift in
            shift.stage != nil
        }
    }
    
    var current: Shift? {
        details.first
    }
    
    var nexts: [Shift] {
        if current != nil {
            return details.suffix(details.count - 1)
        } else {
            return []
        }
    }
    
    var schedules: [Shift] {
        modelData.shifts.filter { shift in
            shift.stage == nil
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
    
    func update() {
        modelData.updateShifts()
    }
}

struct ShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        let modelData = ModelData()
        
        let asset = NSDataAsset(name: "shifts", bundle: Bundle.main)!
        
        _ = modelData.loadShifts(data: asset.data)
        
        return ShiftsView()
            .environmentObject(modelData)
    }
}
