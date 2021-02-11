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
    
    static func gameModeConvertTo(gameMode: GameMode) -> Schedule.GameMode {
        switch gameMode {
        case .regular, .unknown:
            return .regular
        case .gachi:
            return .gachi
        case .league:
            return .league
        }
    }
    
    static func gameModeConvertFrom(gameMode: Schedule.GameMode) -> GameMode {
        switch gameMode {
        case .regular:
            return .regular
        case .gachi:
            return .gachi
        case .league:
            return .league
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
