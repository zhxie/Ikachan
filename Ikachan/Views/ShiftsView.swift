//
//  ShiftsView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI
import Intents

struct ShiftsView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        SchedulesScrollView(data: shifts, title: "salmon_run") { shift in
            ShiftView(shift: shift.0, sequence: shift.1)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    Impact(style: .light)
                    modelData.changeGame()
                    update()
                } label: {
                    Image(systemName: modelData.game.image)
                }
            }
        }
        .onAppear(perform: {
            update()
        })
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                update()
            }
        }
    }
    
    var shifts: [(Shift, Int)] {
        var shifts: [(Shift, Int)] = []
        
        for (i, shift) in modelData.shifts.enumerated() {
            shifts.append((shift, i))
        }
        
        return shifts
    }
    
    func update() {
        modelData.updateShifts()
    }
}

struct ShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftsView()
            .environmentObject(ModelData())
    }
}
