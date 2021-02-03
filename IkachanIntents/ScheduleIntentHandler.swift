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
                completion(ScheduleIntentResponse.failure(gameMode: gameMode.longDescription.localizedString))
                
                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == gameMode
            }
            
            if filtered.count > 0 {
                completion(ScheduleIntentResponse.success(rule: filtered[0].rule.description.localizedString, stages: [filtered[0].stageA.description.localizedString, filtered[0].stageB.description.localizedString], gameMode: gameMode.longDescription.localizedString))
            } else {
                completion(ScheduleIntentResponse.failure(gameMode: gameMode.longDescription.localizedString))
            }
        }
    }
}
