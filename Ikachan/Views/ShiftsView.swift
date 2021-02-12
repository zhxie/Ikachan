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
            LazyVGrid(columns: [GridItem(.adaptive(minimum: ComponentMinWidth), alignment: .top)]) {
                if let first = current {
                    VStack {
                        Divider()
                        
                        ShiftView(shift: first, title: first.status)
                        
                        Spacer()
                            .frame(height: 15)
                    }
                }
                
                ForEach(nexts, id: \.self) { shift in
                    VStack {
                        Divider()
                        
                        ShiftView(shift: shift, title: "next")
                        
                        Spacer()
                            .frame(height: 15)
                    }
                }
                
                ForEach(schedules, id: \.self) { shift in
                    VStack {
                        Divider()
                        
                        ShiftView(shift: shift, title: "future")
                        
                        Spacer()
                            .frame(height: 15)
                    }
                }
            }
            .animation(.default)
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
