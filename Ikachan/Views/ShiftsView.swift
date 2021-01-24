//
//  ShiftsView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/18.
//

import SwiftUI

struct ShiftsView: View {
    @EnvironmentObject var modelData: ModelData
    @Environment(\.scenePhase) var scenePhase
    
    @State var showModal = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let first = current {
                        VStack {
                            Divider()
                            
                            ShiftView(shift: first, title: title(startTime: first.startTime))
                            
                            Spacer()
                                .frame(height: 15)
                        }
                        .animation(.easeInOut)
                    }
                    
                    ForEach(nexts, id: \.self) { shift in
                        VStack {
                            Divider()
                            
                            ShiftView(shift: shift, title: "next")
                            
                            Spacer()
                                .frame(height: 15)
                        }
                        .animation(.easeInOut)
                    }
                    
                    ForEach(schedules, id: \.self) { shift in
                        VStack {
                            Divider()
                            
                            ShiftView(shift: shift, title: "future")
                            
                            Spacer()
                                .frame(height: 15)
                        }
                        .animation(.easeInOut)
                    }
                }
                .padding()
                .navigationTitle("salmon_run")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showModal.toggle()
                    }) {
                        Image(systemName: "info.circle")
                    }.sheet(isPresented: $showModal) {
                        AboutView(showModal: $showModal)
                    }
                    .animation(.easeInOut(duration: 0.2))
                }
            }
        }
        .onAppear(perform: update)
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
    
    func title(startTime: Date) -> LocalizedStringKey {
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
