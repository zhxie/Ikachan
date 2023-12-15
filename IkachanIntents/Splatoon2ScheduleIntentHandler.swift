import Intents

class Splatoon2ScheduleIntentHandler: IntentHandler, Splatoon2ScheduleIntentHandling {
    func resolveMode(for intent: Splatoon2ScheduleIntent, with completion: @escaping (INSplatoon2ScheduleModeResolutionResult) -> Void) {
        if intent.mode == .unknown {
            completion(INSplatoon2ScheduleModeResolutionResult.needsValue())
        } else {
            completion(INSplatoon2ScheduleModeResolutionResult.success(with: intent.mode))
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }

    func handle(intent: Splatoon2ScheduleIntent, completion: @escaping (Splatoon2ScheduleIntentResponse) -> Void) {
        var mode: Splatoon2ScheduleMode = .regularBattle
        switch intent.mode {
        case .unknown, .regularBattle:
            mode = .regularBattle
        case .rankedBattle:
            mode = .rankedBattle
        case .leagueBattle:
            mode = .leagueBattle
        }
        fetchSplatoon2Schedules(locale: Locale.localizedIntentsLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon2ScheduleIntentResponse(code: .failure, userActivity: nil))

                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule._mode == mode
            }.filter { schedule in
                Date() < schedule.endTime
            }
            guard let schedule = filtered.first else {
                completion(Splatoon2ScheduleIntentResponse(code: .failure, userActivity: nil))
                
                return
            }
            
            let dialog = String(format: "schedule_dialog".localizedIntentsString, Game.splatoon2.name.localizedString, schedule.mode.name.localizedIntentsString, schedule.rule.name.localizedIntentsString, schedule.stages[0].name.localizedIntentsString, schedule.stages[1].name.localizedIntentsString)
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(schedule)
            let activity = NSUserActivity(activityType: UserActivity)
            activity.userInfo?["current"] = data.base64EncodedString()
            if let schedule = filtered.at(index: 1) {
                activity.userInfo?["next"] = try! encoder.encode(schedule).base64EncodedString()
            }
            let response = Splatoon2ScheduleIntentResponse.success(dialog: dialog, mode: intent.mode)
            response.userActivity = activity
            completion(response)
        }
    }
}
