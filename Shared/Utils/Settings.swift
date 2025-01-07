import SwiftUI

enum UserDefaultsKey: String {
    case displayOnStartup = "display-on-startup"
    case displayShiftsFirst = "display-shifts-first"
    case splatoon2ScheduleOrder = "splatoon-2-schedule-order"
    case splatoon3ScheduleOrder = "splatoon-3-schedule-order"
    case splatoon3ShiftOrder = "splatoon-3-shift-order"
}

let store = UserDefaults(suiteName: "group.name.sketch.Ikachan")

class Settings: ObservableObject {
    static let shared = Settings()
    
    @AppStorage(UserDefaultsKey.displayOnStartup.rawValue, store: store) private var _displayOnStartup = Game.splatoon3
    @AppStorage(UserDefaultsKey.displayShiftsFirst.rawValue, store: store) private var _displayShiftsFirst = false
    @AppStorage(UserDefaultsKey.splatoon2ScheduleOrder.rawValue, store: store) private var _splatoon2ScheduleOrder = Splatoon2ScheduleMode.allCases
    @AppStorage(UserDefaultsKey.splatoon3ScheduleOrder.rawValue, store: store) private var _splatoon3ScheduleOrder = Splatoon3ScheduleMode.allCases
    @AppStorage(UserDefaultsKey.splatoon3ShiftOrder.rawValue, store: store) private var _splatoon3ShiftOrder = Splatoon3ShiftMode.allCases
    
    var displayOnStartup: Game {
        return _displayOnStartup
    }
}
