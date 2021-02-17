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
            completion(GameModeResolutionResult.needsValue())
        } else {
            completion(GameModeResolutionResult.success(with: intent.gameMode))
        }
    }
    
    func resolveRotation(for intent: ScheduleIntent, with completion: @escaping (RotationResolutionResult) -> Void) {
        if intent.rotation == .unknown {
            completion(RotationResolutionResult.needsValue())
        } else {
            completion(RotationResolutionResult.success(with: intent.rotation))
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    func handle(intent: ScheduleIntent, completion: @escaping (ScheduleIntentResponse) -> Void) {
        let gameMode = IntentHandler.gameModeConvertTo(gameMode: intent.gameMode)
        fetchSchedules { (schedules, error) in
            guard let schedules = schedules else {
                completion(ScheduleIntentResponse(code: .failure, userActivity: nil))

                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.gameMode == IntentHandler.gameModeConvertTo(gameMode: intent.gameMode)
            }
            
            guard let schedule = filtered.at(index: IntentHandler.rotationConvertTo(rotation: intent.rotation)) else {
                completion(ScheduleIntentResponse(code: .failure, userActivity: nil))
                
                return
            }
            
            var formatter = ""
            switch intent.rotation {
            case .unknown, .current:
                formatter = "current_schedule"
            case .next:
                formatter = "next_schedule"
            }
            
            let result = String(format: formatter.localizedIntentsString, gameMode.description.rawValue.localizedIntentsString, schedule.rule.description.rawValue.localizedIntentsString, schedule.stageA.description.rawValue.localizedIntentsString, schedule.stageB.description.rawValue.localizedIntentsString, absoluteLongIntentsTimeSpan(current: Date(), startTime: schedule.startTime, endTime: schedule.endTime))
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(schedule)
            let activity = NSUserActivity(activityType: IkachanSchedulesActivity + "." + gameMode.rawValue)
            activity.userInfo?["schedule"] = data.base64EncodedString()
            let response = ScheduleIntentResponse.success(result: result, rotation: intent.rotation, gameMode: intent.gameMode)
            response.userActivity = activity
            completion(response)
        }
    }
}
