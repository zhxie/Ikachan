//
//  ShiftIntentHandler.swift
//  IkachanIntents
//
//  Created by Sketch on 2021/2/3.
//

import Intents

class Splatoon2ShiftIntentHandler: IntentHandler, Splatoon2ShiftIntentHandling {
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    func handle(intent: Splatoon2ShiftIntent, completion: @escaping (Splatoon2ShiftIntentResponse) -> Void) {
        fetchSplatoon2Shifts(locale: Locale.localizedIntentsLocale) { shifts, error in
            guard error == .NoError else {
                completion(Splatoon2ShiftIntentResponse(code: .failure, userActivity: nil))
                
                return
            }
            
            let details = shifts.filter { shift in
                shift.stage != nil
            }
            guard let shift = details.at(index: 0) else {
                completion(Splatoon2ShiftIntentResponse(code: .failure, userActivity: nil))
                
                return
            }
            
            var formatter = ""
            if shift.startTime > Date() {
                formatter = "soon_shift_dialog"
            } else {
                formatter = "shift_dialog"
            }
            let dialog = String(format: formatter.localizedIntentsString, Game.splatoon2.name.localizedString, shift.mode.name.localizedIntentsString, shift.stage!.name.localizedIntentsString, shift.weapons![0].name.localizedIntentsString, shift.weapons![1].name.localizedIntentsString, shift.weapons![2].name.localizedIntentsString, shift.weapons![3].name.localizedIntentsString)
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(shift)
            let activity = NSUserActivity(activityType: UserActivity)
            activity.userInfo?["splatoon2Shift"] = data.base64EncodedString()
            let response = Splatoon2ShiftIntentResponse.success(dialog: dialog)
            response.userActivity = activity
            completion(response)
        }
    }
}
