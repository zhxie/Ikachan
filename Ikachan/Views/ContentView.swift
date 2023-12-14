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
    
    @State var isInfoPresented = false
    
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
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 450, maximum: 900))]) {
                                ForEach(Splatoon2ScheduleMode.allCases, id: \.rawValue) { mode in
                                    if !splatoon2Schedules.filter({ schedule in
                                        schedule._mode == mode
                                    }).isEmpty {
                                        SchedulesNavigationLink(schedules: splatoon2Schedules.filter { schedule in
                                            schedule._mode == mode
                                        })
                                    }
                                }
                                if !splatoon2Shifts.isEmpty {
                                    ShiftsNavigationLink(shifts: splatoon2Shifts)
                                }
                            }
                            .padding([.horizontal])
                        case .splatoon3:
                            if !splatoon3Schedules.filter({ schedule in
                                schedule._mode == .tricolorBattle
                            }).isEmpty {
                                SchedulesNavigationLink(schedules: splatoon3Schedules.filter { schedule in
                                    schedule._mode == .tricolorBattle
                                })
                                .padding([.horizontal])
                            }
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 450, maximum: 900))]) {
                                ForEach([Splatoon3ScheduleMode.splatfestBattleOpen, Splatoon3ScheduleMode.splatfestBattlePro, Splatoon3ScheduleMode.regularBattle, Splatoon3ScheduleMode.anarchyBattleSeries, Splatoon3ScheduleMode.anarchyBattleOpen, Splatoon3ScheduleMode.xBattle, Splatoon3ScheduleMode.challenges], id: \.rawValue) { mode in
                                    if !splatoon3Schedules.filter({ schedule in
                                        schedule._mode == mode
                                    }).isEmpty {
                                        SchedulesNavigationLink(schedules: splatoon3Schedules.filter { schedule in
                                            schedule._mode == mode
                                        })
                                    }
                                }
                                ForEach(Splatoon3ShiftMode.allCases, id: \.rawValue) { mode in
                                    if !splatoon3Shifts.filter({ shift in
                                        shift._mode == mode
                                    }).isEmpty {
                                        ShiftsNavigationLink(shifts: splatoon3Shifts.filter { shift in
                                            shift._mode == mode
                                        })
                                    }
                                }
                            }
                            .padding([.horizontal])
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
                Button {
                    isInfoPresented.toggle()
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .navigationViewStyle(.stack)
        .onAppear {
            update()
        }
        .sheet(isPresented: $isInfoPresented) {
            AboutView()
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
