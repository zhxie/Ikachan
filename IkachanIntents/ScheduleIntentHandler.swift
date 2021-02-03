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
            completion(GameModeResolutionResult.confirmationRequired(with: GameMode.regular))
        } else {
            completion(GameModeResolutionResult.success(with: intent.gameMode))
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
        ModelData.fetchSchedules { (schedules, error) in
            guard let schedules = schedules else {
                completion(ScheduleIntentResponse.failure(gameMode: intent.gameMode))
                
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == ScheduleIntentHandler.convertTo(gameMode: intent.gameMode)
            }
            
            if filtered.count > 0 {
                let result = String(format: "current_schedule".localizedStringForSiri, gameMode.longDescription.rawValue.localizedStringForSiri, filtered[0].rule.description.rawValue.localizedStringForSiri, filtered[0].stageA.description.rawValue.localizedStringForSiri, filtered[0].stageB.description.rawValue.localizedStringForSiri)
                
                let response = ScheduleIntentResponse.success(result: result, gameMode: intent.gameMode)
                response.userActivity = NSUserActivity(activityType: String(format: "name.sketch.Ikachan.schedule.%@", gameMode.rawValue))
                completion(response)
            } else {
                completion(ScheduleIntentResponse.failure(gameMode: intent.gameMode))
            }
        }
    }
}
