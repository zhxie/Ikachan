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
        SchedulesScrollView(data: modelData.shifts, title: "salmon_run") { shift in
            ShiftView(shift: shift)
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
