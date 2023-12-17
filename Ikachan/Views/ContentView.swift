import SwiftUI
import AlertKit

struct ContentView: View {
    @State var game = Settings.shared.displayOnStartup
    @State var splatoon2Error: Error? = nil
    @State var splatoon2Schedules: [Splatoon2Schedule] = []
    @State var splatoon2Shifts: [Splatoon2Shift] = []
    @State var splatoon3Error: Error? = nil
    @State var splatoon3Schedules: [Splatoon3Schedule] = []
    @State var splatoon3Shifts: [Splatoon3Shift] = []
    @State var splatoon2Status = Status.Normal
    @State var splatoon3Status = Status.Normal
    
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
                            if splatoon2Status != .Normal {
                                VStack {
                                    Text(LocalizedStringKey(splatoon2Status.name))
                                        .font(.subheadline)
                                        .foregroundColor(Color(.secondaryLabel))
                                        .padding([.horizontal, .top])
                                    
                                    // HACK: To occupy horizontal space.
                                    HStack {
                                        Spacer()
                                    }
                                    
                                    SafariButton(title: LocalizedStringKey("support"), url: URL(string: String(format: "https://www.nintendo.co.jp/netinfo/%@/index.html", Locale.localizedLocale.maintenanceInformationAndOperationalStatusLanguageCode))!)
                                        .font(.footnote)
                                        .padding([.horizontal, .bottom])
                                }
                                .background {
                                    Color(.secondarySystemBackground)
                                }
                                .cornerRadius(16)
                                .padding([.horizontal])
                            }
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 450, maximum: 900))]) {
                                if Settings.shared.displayShiftsFirst && !splatoon2Shifts.isEmpty {
                                    ShiftsNavigationLink(shifts: splatoon2Shifts)
                                }
                                ForEach(Settings.shared.splatoon2ScheduleOrder, id: \.self) { mode in
                                    if !splatoon2Schedules.filter({ schedule in
                                        schedule._mode == mode
                                    }).isEmpty {
                                        SchedulesNavigationLink(schedules: splatoon2Schedules.filter { schedule in
                                            schedule._mode == mode
                                        })
                                    }
                                }
                                if !Settings.shared.displayShiftsFirst && !splatoon2Shifts.isEmpty {
                                    ShiftsNavigationLink(shifts: splatoon2Shifts)
                                }
                            }
                            .padding([.horizontal])
                        case .splatoon3:
                            if splatoon3Status != .Normal {
                                VStack {
                                    Text(LocalizedStringKey(splatoon3Status.name))
                                        .font(.subheadline)
                                        .foregroundColor(Color(.secondaryLabel))
                                        .padding([.horizontal, .top])
                                    
                                    // HACK: To occupy horizontal space.
                                    HStack {
                                        Spacer()
                                    }
                                    
                                    SafariButton(title: LocalizedStringKey("support"), url: URL(string: String(format: "https://www.nintendo.co.jp/netinfo/%@/index.html", Locale.localizedLocale.maintenanceInformationAndOperationalStatusLanguageCode))!)
                                        .font(.footnote)
                                        .padding([.horizontal, .bottom])
                                }
                                .background {
                                    Color(.secondarySystemBackground)
                                }
                                .cornerRadius(16)
                                .padding([.horizontal])
                            }
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 450, maximum: 900))]) {
                                if Settings.shared.displayShiftsFirst {
                                    ForEach(Settings.shared.splatoon3ShiftOrder, id: \.self) { mode in
                                        if !splatoon3Shifts.filter({ shift in
                                            shift._mode == mode
                                        }).isEmpty {
                                            ShiftsNavigationLink(shifts: splatoon3Shifts.filter { shift in
                                                shift._mode == mode
                                            })
                                        }
                                    }
                                }
                                ForEach(Settings.shared.splatoon3ScheduleOrder, id: \.self) { mode in
                                    if !splatoon3Schedules.filter({ schedule in
                                        schedule._mode == mode
                                    }).isEmpty {
                                        SchedulesNavigationLink(schedules: splatoon3Schedules.filter { schedule in
                                            schedule._mode == mode
                                        })
                                    }
                                }
                                if !Settings.shared.displayShiftsFirst {
                                    ForEach(Settings.shared.splatoon3ShiftOrder, id: \.self) { mode in
                                        if !splatoon3Shifts.filter({ shift in
                                            shift._mode == mode
                                        }).isEmpty {
                                            ShiftsNavigationLink(shifts: splatoon3Shifts.filter { shift in
                                                shift._mode == mode
                                            })
                                        }
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
                    Image(systemName: "gear")
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
        fetchMaintenanceInformationAndOperationalStatus { splatoon2Status, splatoon3Status, error in
            if error == .NoError {
                withAnimation {
                    self.splatoon2Status = splatoon2Status
                    self.splatoon3Status = splatoon3Status
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
