//
//  IntentHandler.swift
//  IkachanIntents
//
//  Created by Sketch on 2021/2/2.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        if intent is ScheduleIntent {
            return ScheduleIntentHandler()
        } else if intent is ShiftIntent {
            return ShiftIntentHandler()
        } else {
            return self
        }
    }
    
    static func modeConvertTo(mode: INMode) -> Mode {
        switch mode {
        case .regular, .unknown:
            return Splatoon2ScheduleMode.regular
        case .gachi:
            return Splatoon2ScheduleMode.gachi
        case .league:
            return Splatoon2ScheduleMode.league
        }
    }
    
    static func modeConvertFrom(mode: Mode) -> INMode {
        switch mode.name {
        case "regular":
            return .regular
        case "gachi":
            return .gachi
        case "league":
            return .league
        default:
            return .unknown
        }
    }
    
    static func rotationConvertTo(rotation: Rotation) -> Int {
        switch rotation {
        case .current, .unknown:
            return 0
        case .next:
            return 1
        }
    }
}
