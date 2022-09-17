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

    @Binding var showModal: Bool?
    
    init() {
        _showModal = .constant(nil)
    }
    init(showModal: Binding<Bool>) {
        _showModal = Binding(showModal)
    }
    
    var body: some View {
        SchedulesScrollView(data: shifts, title: "salmon_run") { shift in
            ShiftView(shift: shift.0, isFirst: shift.1)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if showModal != nil {
                    Button(action: {
                        showModal!.toggle()
                    }) {
                        Image(systemName: "info.circle")
                    }
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
    
    var shifts: [(Shift, Bool)] {
        var shifts: [(Shift, Bool)] = []
        
        for (i, shift) in modelData.shifts.enumerated() {
            shifts.append((shift, i == 0))
        }
        
        return shifts
    }
    
    func update() {
        modelData.updateShifts()
    }
}

struct ShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftsView(showModal: .constant(false))
            .environmentObject(ModelData())
    }
}
