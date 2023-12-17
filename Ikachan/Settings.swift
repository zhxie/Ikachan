import SwiftUI

enum UserDefaultsKey: String {
    case displayOnStartup = "display-on-startup"
    case displayShiftsFirst = "display-shifts-first"
    case splatoon2ScheduleOrder = "splatoon-2-schedule-order"
    case splatoon3ShiftFirst = "splatoon-3-shift-first"
    case splatoon3ScheduleOrder = "splatoon-3-schedule-order"
    case splatoon3ShiftOrder = "splatoon-3-shift-order"
}

class Settings: ObservableObject {
    static let shared = Settings()
    
    @AppStorage(UserDefaultsKey.displayOnStartup.rawValue) var _displayOnStartup = Game.splatoon3.rawValue
    @AppStorage(UserDefaultsKey.displayShiftsFirst.rawValue) var displayShiftsFirst = false
    @AppStorage(UserDefaultsKey.splatoon2ScheduleOrder.rawValue) var _splatoon2ScheduleOrder = Splatoon2ScheduleMode.allCases.map { mode in
        mode.rawValue
    }.joined(separator: ",")
    @AppStorage(UserDefaultsKey.splatoon3ScheduleOrder.rawValue) var _splatoon3ScheduleOrder = Splatoon3ScheduleMode.allCases.map { mode in
        mode.rawValue
    }.joined(separator: ",")
    @AppStorage(UserDefaultsKey.splatoon3ShiftOrder.rawValue) var _splatoon3ShiftOrder = Splatoon3ShiftMode.allCases.map { mode in
        mode.rawValue
    }.joined(separator: ",")
    
    var displayOnStartup: Game {
        get {
            return Game(rawValue: _displayOnStartup) ?? .splatoon3
        }
        set {
            _displayOnStartup = newValue.rawValue
        }
    }
    
    var splatoon2ScheduleOrder: [Splatoon2ScheduleMode] {
        get {
            return parseFromOrderString(order: _splatoon2ScheduleOrder)
        }
        set {
            _splatoon2ScheduleOrder = joinToOrderString(modes: newValue)
        }
    }
    var splatoon3ScheduleOrder: [Splatoon3ScheduleMode] {
        get {
            return parseFromOrderString(order: _splatoon3ScheduleOrder)
        }
        set {
            _splatoon3ScheduleOrder = joinToOrderString(modes: newValue)
        }
    }
    var splatoon3ShiftOrder: [Splatoon3ShiftMode] {
        get {
            return parseFromOrderString(order: _splatoon3ShiftOrder)
        }
        set {
            _splatoon3ShiftOrder = joinToOrderString(modes: newValue)
        }
    }
    
    private func parseFromOrderString<T: Hashable>(order: String) -> [T] where T: Mode, T: RawRepresentable, T.RawValue == String {
        var modes: [T] = []
        for mode in order.split(separator: ",") {
            if let mode = T(rawValue: String(mode)) {
                modes.append(mode)
            }
        }
        modes = modes.uniqued()
        for mode in T.allCases {
            if !modes.contains(mode) {
                modes.append(mode)
            }
        }
        return modes
    }
    private func joinToOrderString<T: Hashable>(modes: [T]) -> String where T: Mode {
        var modes = modes.uniqued()
        for mode in T.allCases {
            if !modes.contains(mode) {
                modes.append(mode)
            }
        }
        return modes.map { mode in
            mode.name
        }.joined(separator: ",")
    }
}
