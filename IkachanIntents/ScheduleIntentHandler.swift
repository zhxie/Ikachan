//
//  ScheduleIntentHandler.swift
//  IkachanIntents
//
//  Created by Sketch on 2021/2/3.
//

import Intents

class ScheduleIntentHandler: IntentHandler, ScheduleIntentHandling {
    func resolveGame(for intent: ScheduleIntent, with completion: @escaping (INGameResolutionResult) -> Void) {
        if intent.game == .unknown {
            completion(INGameResolutionResult.needsValue())
        } else {
            completion(INGameResolutionResult.success(with: intent.game))
        }
    }
    func resolveMode(for intent: ScheduleIntent, with completion: @escaping (INModeResolutionResult) -> Void) {
        if intent.mode == .unknown {
            completion(INModeResolutionResult.needsValue())
        } else {
            completion(INModeResolutionResult.success(with: intent.mode))
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
        let game = Game(intent: intent.game)
        var mode: Mode?
        switch game {
        case .splatoon2:
            mode = Splatoon2ScheduleMode(intent: intent.mode)
        case .splatoon3:
            mode = Splatoon3ScheduleMode(intent: intent.mode)
        }
        guard let mode = mode else {
            completion(ScheduleIntentResponse(code: .failure, userActivity: nil))
            
            return
        }
        
        fetchSchedules(game: game) { schedules, error in
            guard let schedules = schedules else {
                completion(ScheduleIntentResponse(code: .failure, userActivity: nil))

                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule.mode.intent == intent.mode
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
            let result = String(format: formatter.localizedIntentsString, game.name.localizedString, mode.name.localizedIntentsString, schedule.rule.name.localizedIntentsString, schedule.stages[0].name.localizedIntentsString, schedule.stages[1].name.localizedIntentsString, intentsLongTimeSpan(current: Date(), startTime: schedule.startTime, endTime: schedule.endTime))
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(schedule)
            let activity = NSUserActivity(activityType: IkachanSchedulesActivity + "." + mode.name)
            activity.userInfo?["schedule"] = data.base64EncodedString()
            let response = ScheduleIntentResponse.success(result: result, mode: intent.mode)
            response.game = intent.game
            response.rotation = intent.rotation
            response.userActivity = activity
            completion(response)
        }
    }
}
