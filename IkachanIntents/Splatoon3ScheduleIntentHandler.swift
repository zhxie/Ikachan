import Intents

class Splatoon3ScheduleIntentHandler: IntentHandler, Splatoon3ScheduleIntentHandling {
    func resolveMode(for intent: Splatoon3ScheduleIntent, with completion: @escaping (INSplatoon3ScheduleModeResolutionResult) -> Void) {
        if intent.mode == .unknown {
            completion(INSplatoon3ScheduleModeResolutionResult.needsValue())
        } else {
            completion(INSplatoon3ScheduleModeResolutionResult.success(with: intent.mode))
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }

    func handle(intent: Splatoon3ScheduleIntent, completion: @escaping (Splatoon3ScheduleIntentResponse) -> Void) {
        var mode: Splatoon3ScheduleMode = .regularBattle
        switch intent.mode {
        case .unknown, .regularBattle:
            mode = .regularBattle
        case .anarchyBattleSeries:
            mode = .anarchyBattleSeries
        case .anarchyBattleOpen:
            mode = .anarchyBattleOpen
        case .xBattle:
            mode = .xBattle
        case .challenges:
            mode = .challenges
        case .splatfestBattleOpen:
            mode = .splatfestBattleOpen
        case .splatfestBattlePro:
            mode = .splatfestBattlePro
        case .tricolorBattle:
            mode = .tricolorBattle
        }
        fetchSplatoon3Schedules(locale: Locale.localizedIntentsLocale) { schedules, error in
            guard error == .NoError else {
                completion(Splatoon3ScheduleIntentResponse(code: .failure, userActivity: nil))

                return
            }
            
            let filtered = schedules.filter { schedule in
                schedule._mode == mode
            }.filter { schedule in
                Date() < schedule.endTime
            }
            guard let schedule = filtered.first else {
                completion(Splatoon3ScheduleIntentResponse(code: .failure, userActivity: nil))
                
                return
            }
            
            let dialog = String(format: "schedule_dialog".localizedIntentsString, Game.splatoon3.name.localizedString, schedule.mode.name.localizedIntentsString, schedule.rule.name.localizedIntentsString, schedule.stages[0].name.localizedIntentsString, schedule.stages[1].name.localizedIntentsString)
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(schedule)
            let activity = NSUserActivity(activityType: UserActivity)
            activity.userInfo?["current"] = data.base64EncodedString()
            if let schedule = filtered.at(index: 1) {
                activity.userInfo?["next"] = try! encoder.encode(schedule).base64EncodedString()
            }
            let response = Splatoon3ScheduleIntentResponse.success(dialog: dialog, mode: intent.mode)
            response.userActivity = activity
            completion(response)
        }
    }
}
