import SwiftUI

struct ContentView: View {
    @ObservedObject var settings = Settings.shared
    
    @State var game = Settings.shared.displayOnStartup
    @State var splatoon2Error: APIError? = nil
    @State var splatoon2Schedules: [Splatoon2Schedule] = []
    @State var splatoon2Shifts: [Splatoon2Shift] = []
    @State var splatoon3Error: APIError? = nil
    @State var splatoon3Schedules: [Splatoon3Schedule] = []
    @State var splatoon3Shifts: [Splatoon3Shift] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                if game == .splatoon2 && splatoon2Error == nil || game == .splatoon3 && splatoon3Error == nil {
                    ProgressView()
                } else {
                    switch game {
                    case .splatoon2:
                        if splatoon2Error == .NoError {
                            TabView {
                                SwappableView(isSwapped: settings.displayShiftsFirst) {
                                    ForEach(settings.splatoon2ScheduleOrder, id: \.self) { mode in
                                        if !splatoon2Schedules.filter({ schedule in
                                            schedule._mode == mode
                                        }).isEmpty {
                                            SchedulesView(mode: mode, schedules: splatoon2Schedules.filter { schedule in
                                                schedule._mode == mode
                                            })
                                            .navigationTitle(LocalizedStringKey(mode.shortName))
                                        }
                                    }
                                } content2: {
                                    if !splatoon2Shifts.isEmpty {
                                        ShiftsView(mode: Splatoon2ShiftMode.salmonRun, shifts: splatoon2Shifts)
                                            .navigationTitle(LocalizedStringKey(Splatoon2ShiftMode.salmonRun.shortName))
                                    }
                                }
                            }
                            .verticalPageTabViewStyle()
                        } else {
                            ErrorView(error: splatoon2Error!)
                        }
                    case .splatoon3:
                        if splatoon3Error == .NoError {
                            TabView {
                                SwappableView(isSwapped: settings.displayShiftsFirst) {
                                    ForEach(settings.splatoon3ScheduleOrder, id: \.self) { mode in
                                        if !splatoon3Schedules.filter({ schedule in
                                            schedule._mode == mode
                                        }).isEmpty {
                                            SchedulesView(mode: mode, schedules: splatoon3Schedules.filter { schedule in
                                                schedule._mode == mode
                                            })
                                            .navigationTitle(LocalizedStringKey(mode.shortName))
                                        }
                                    }
                                } content2: {
                                    ForEach(settings.splatoon3ShiftOrder, id: \.self) { mode in
                                        if !splatoon3Shifts.filter({ shift in
                                            shift._mode == mode
                                        }).isEmpty {
                                            ShiftsView(mode: mode, shifts: splatoon3Shifts.filter { shift in
                                                shift._mode == mode
                                            })
                                            .navigationTitle(LocalizedStringKey(mode.shortName))
                                        }
                                    }
                                }
                            }
                            .verticalPageTabViewStyle()
                        } else {
                            ErrorView(error: splatoon3Error!)
                        }
                    }
                }
            }
            .navigationTitle(LocalizedStringKey(game.name))
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        withAnimation {
                            switch game {
                            case .splatoon2:
                                game = .splatoon3
                            case .splatoon3:
                                game = .splatoon2
                            }
                            update() {}
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
        }
        .refreshable {
            // HACK: Introduce refreshable will cause data races since we do not have any guard to avoid multiple updates.
            await withCheckedContinuation { continuation in
                update {
                    continuation.resume()
                }
            }
        }
        .onAppear {
            update() {}
        }
    }
    
    func update(completion: @escaping () -> Void) {
        switch game {
        case .splatoon2:
            fetchSplatoon2(locale: Locale.localizedLocale) { schedules, shifts, error in
                withAnimation {
                    splatoon2Error = error
                    splatoon2Schedules = schedules.filter { schedule in
                        schedule.endTime > Date()
                    }
                    splatoon2Shifts = shifts.filter { shift in
                        shift.endTime > Date()
                    }
                }
                // TODO: Show error with elegance in watchOS.
                completion()
            }
        case .splatoon3:
            fetchSplatoon3(locale: Locale.localizedLocale) { schedules, shifts, error in
                withAnimation {
                    splatoon3Error = error
                    splatoon3Schedules = schedules.filter { schedule in
                        schedule.endTime > Date()
                    }
                    splatoon3Shifts = shifts.filter { shift in
                        shift.endTime > Date()
                    }
                }
                // TODO: Show error with elegance in watchOS.
                completion()
            }
        }
    }
}

#Preview {
    ContentView()
}
