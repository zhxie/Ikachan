//
//  ScheduleIntentHandler.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/3.
//

import Intents

class ScheduleIntentHandler: IntentHandler, ScheduleIntentHandling {
    func resolveGameMode(for intent: ScheduleIntent, with completion: @escaping (GameModeResolutionResult) -> Void) {
        if intent.gameMode == .unknown {
            completion(GameModeResolutionResult.confirmationRequired(with: .regular))
        } else {
            completion(GameModeResolutionResult.success(with: intent.gameMode))
        }
    }
    
    func resolveRotation(for intent: ScheduleIntent, with completion: @escaping (RotationResolutionResult) -> Void) {
        if intent.rotation == .unknown {
            completion(RotationResolutionResult.confirmationRequired(with: .current))
        } else {
            completion(RotationResolutionResult.success(with: intent.rotation))
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    static func convertTo(gameMode: GameMode) -> Schedule.GameMode {
        switch gameMode {
        case .regular:
            return .regular
        case .gachi:
            return .gachi
        case .league:
            return .league
        default:
            return .regular
        }
    }
    
    static func convertFrom(gameMode: Schedule.GameMode) -> GameMode {
        switch gameMode {
        case .regular:
            return .regular
        case .gachi:
            return .gachi
        case .league:
            return .league
        }
    }
    
    func handle(intent: ScheduleIntent, completion: @escaping (ScheduleIntentResponse) -> Void) {
        let gameMode = ScheduleIntentHandler.convertTo(gameMode: intent.gameMode)
        fetchSchedules { (schedules, error) in
            guard let schedules = schedules else {
                completion(ScheduleIntentResponse.init(code: .failure, userActivity: nil))

                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == ScheduleIntentHandler.convertTo(gameMode: intent.gameMode)
            }
            
            var formatter = ""
            var schedule: Schedule? = nil
            
            switch intent.rotation {
            case .unknown, .current:
                formatter = "current_schedule"
                schedule = filtered.at(index: 0)
            case .next:
                formatter = "next_schedule"
                schedule = filtered.at(index: 1)
            }
            
            guard let s = schedule else {
                completion(ScheduleIntentResponse.init(code: .failure, userActivity: nil))
                
                return
            }
            
            let result = String(format: formatter.localizedIntentsString, gameMode.longDescription.rawValue.localizedIntentsString, s.rule.description.rawValue.localizedIntentsString, s.stageA.description.rawValue.localizedIntentsString, s.stageB.description.rawValue.localizedIntentsString, absoluteLongIntentsTimeSpan(current: Date(), startTime: s.startTime, endTime: s.endTime))
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(s)
            let activity = NSUserActivity(activityType: String(format: "name.sketch.Ikachan.schedule.%@", gameMode.rawValue))
            activity.userInfo?["schedule"] = data.base64EncodedString()
            let response = ScheduleIntentResponse.success(result: result, rotation: intent.rotation, gameMode: intent.gameMode)
            response.userActivity = activity
            completion(response)
        }
    }
}
