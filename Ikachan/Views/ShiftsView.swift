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
        ScrollView {
            VStack {
                ForEach(shifts, id: \.self) { shift in
                    VStack {
                        Divider()
                        
                        ShiftView(shift: shift.shift, title: shift.status)
                        
                        Spacer()
                            .frame(height: 15)
                    }
                    .transition(.opacity)
                    .animation(.default)
                }
            }
            .padding([.horizontal, .bottom])
        }
        .navigationTitle("salmon_run")
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
            interact()
            
            update()
        })
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                update()
            }
        }
    }
    
    var shifts: [FilteredShift] {
        var shifts: [FilteredShift] = []
        
        // First
        for (i, shift) in modelData.shifts.enumerated() {
            shifts.append(FilteredShift(isFirst: i == 0, shift: shift))
        }
        
        return shifts
    }
    
    func update() {
        modelData.updateShifts()
    }
    
    func interact() {
        INInteraction(intent: ShiftIntent(), response: nil).donate(completion: nil)
    }
}

struct ShiftsView_Previews: PreviewProvider {
    static var previews: some View {
        ShiftsView(showModal: .constant(false))
            .environmentObject(ModelData())
    }
}
