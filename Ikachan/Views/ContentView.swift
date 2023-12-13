//
//  ContentView.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI
import AlertKit

struct ContentView: View {
    @State var game = Game.splatoon3
    @State var splatoon2Error: Error? = nil
    @State var splatoon2Schedules: [Splatoon2Schedule] = []
    @State var splatoon2Shifts: [Splatoon2Shift] = []
    @State var splatoon3Error: Error? = nil
    @State var splatoon3Schedules: [Splatoon3Schedule] = []
    @State var splatoon3Shifts: [Splatoon3Shift] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                if game == .splatoon2 && splatoon2Error == nil || game == .splatoon3 && splatoon3Error == nil {
                    ProgressView()
                } else {
                    ScrollView {
                        // HACK: To occupy horizontal space in advance.
                        HStack {
                            Spacer()
                        }

                        switch game {
                        case .splatoon2:
                            ForEach(Splatoon2ScheduleMode.allCases, id: \.rawValue) { mode in
                                if !splatoon2Schedules.filter({ schedule in
                                    schedule._mode == mode
                                }).isEmpty {
                                    SchedulesNavigationLink(schedules: splatoon2Schedules.filter { schedule in
                                        schedule._mode == mode
                                    })
                                    .padding([.horizontal])
                                }
                            }
                            if !splatoon2Shifts.isEmpty {
                                ShiftsNavigationLink(shifts: splatoon2Shifts)
                                    .padding([.horizontal])
                            }
                        case .splatoon3:
                            ForEach(Splatoon3ScheduleMode.allCases, id: \.rawValue) { mode in
                                if !splatoon3Schedules.filter({ schedule in
                                    schedule._mode == mode
                                }).isEmpty {
                                    SchedulesNavigationLink(schedules: splatoon3Schedules.filter { schedule in
                                        schedule._mode == mode
                                    })
                                    .padding([.horizontal])
                                }
                            }
                            ForEach(Splatoon3ShiftMode.allCases, id: \.rawValue) { mode in
                                if !splatoon3Shifts.filter({ shift in
                                    shift._mode == mode
                                }).isEmpty {
                                    ShiftsNavigationLink(shifts: splatoon3Shifts.filter { shift in
                                        shift._mode == mode
                                    })
                                    .padding([.horizontal])
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(LocalizedStringKey(game.name))
            .toolbar {
                Button {
                    withAnimation {
                        switch game {
                        case .splatoon2:
                            game = .splatoon3
                        case .splatoon3:
                            game = .splatoon2
                        }
                        update()
                    }
                } label: {
                    switch game {
                    case .splatoon2:
                        Image(systemName: "2.circle")
                    case .splatoon3:
                        Image(systemName: "3.circle")
                    }
                }
            }
        }
        .onAppear {
            update()
        }
    }
    
    func update() {
        switch game {
        case .splatoon2:
            fetchSplatoon2(locale: Locale.localizedLocale) { schedules, shifts, error in
                withAnimation {
                    splatoon2Error = error
                    splatoon2Schedules = schedules
                    splatoon2Shifts = shifts
                }
                if error != .NoError {
                    AlertKitAPI.present(title: error.name.localizedString, icon: .error, style: .iOS17AppleMusic, haptic: .error)
                }
            }
        case .splatoon3:
            fetchSplatoon3(locale: Locale.localizedLocale) { schedules, shifts, error in
                withAnimation {
                    splatoon3Error = error
                    splatoon3Schedules = schedules
                    splatoon3Shifts = shifts
                }
                if error != .NoError {
                    AlertKitAPI.present(title: error.name.localizedString, icon: .error, style: .iOS17AppleMusic, haptic: .error)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
