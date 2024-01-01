import Intents

class Splatoon3ShiftIntentHandler: IntentHandler, Splatoon3ShiftIntentHandling {
    func resolveMode(for intent: Splatoon3ShiftIntent, with completion: @escaping (INSplatoon3ShiftModeResolutionResult) -> Void) {
        if intent.mode == .unknown {
            completion(INSplatoon3ShiftModeResolutionResult.needsValue())
        } else {
            completion(INSplatoon3ShiftModeResolutionResult.success(with: intent.mode))
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }

    func handle(intent: Splatoon3ShiftIntent, completion: @escaping (Splatoon3ShiftIntentResponse) -> Void) {
        fetchSplatoon3Shifts(locale: Locale.localizedIntentsLocale) { shifts, error in
            guard error == .NoError else {
                completion(Splatoon3ShiftIntentResponse(code: .failure, userActivity: nil))

                return
            }
            
            let filtered = shifts.filter { shift in
                switch intent.mode {
                case .unknown, .salmonRunAndBigRun:
                    return shift._mode == .salmonRun || shift._mode == .bigRun
                case .eggstraWork:
                    return shift._mode == .eggstraWork
                }
            }.filter { schedule in
                Date() < schedule.endTime
            }.sorted { a, b in
                a.startTime < b.startTime
            }
            guard let shift = filtered.first else {
                completion(Splatoon3ShiftIntentResponse(code: .failure, userActivity: nil))
                
                return
            }
            
            let dialog = String(format: "shift_dialog".localizedIntentsString, Game.splatoon3.name.localizedString, shift.mode.name.localizedIntentsString, shift.stage!.name.localizedIntentsString, shift.weapons![0].name.localizedIntentsString, shift.weapons![1].name.localizedIntentsString, shift.weapons![2].name.localizedIntentsString, shift.weapons![3].name.localizedIntentsString)
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(shift)
            let activity = NSUserActivity(activityType: UserActivity)
            activity.userInfo?["current"] = data.base64EncodedString()
            if let shift = filtered.at(index: 1) {
                activity.userInfo?["next"] = try! encoder.encode(shift).base64EncodedString()
            }
            let response = Splatoon3ShiftIntentResponse.success(dialog: dialog, mode: intent.mode)
            response.userActivity = activity
            completion(response)
        }
    }
}
