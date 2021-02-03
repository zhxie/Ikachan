//
//  ShiftIntentHandler.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/3.
//

import Intents

class ShiftIntentHandler: IntentHandler, ShiftIntentHandling {
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    func handle(intent: ShiftIntent, completion: @escaping (ShiftIntentResponse) -> Void) {
        ModelData.fetchShifts { (shifts, error) in
            guard let shifts = shifts else {
                completion(ShiftIntentResponse(code: .failure, userActivity: nil))
                
                return
            }
            
            let details = shifts.filter { shift in
                shift.stage != nil
            }
            
            if details.count > 0 {
                var formatter = "current_shift"
                if details[0].startTime > Date() {
                    formatter = "soon_shift"
                }
                
                let result = String(format: formatter.localizedStringForSiri, details[0].stage!.description.rawValue.localizedStringForSiri, details[0].weapons[0].description.rawValue.localizedStringForSiri, details[0].weapons[1].description.rawValue.localizedStringForSiri, details[0].weapons[2].description.rawValue.localizedStringForSiri, details[0].weapons[3].description.rawValue.localizedStringForSiri, absoluteLongSiriTimeSpan(current: Date(), startTime: details[0].startTime, endTime: details[0].endTime))
                
                let response = ShiftIntentResponse.success(result: result)
                response.userActivity = NSUserActivity(activityType: "name.sketch.Ikachan.shift")
                completion(response)
            } else {
                completion(ShiftIntentResponse(code: .failure, userActivity: nil))
            }
        }
    }
}