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
                
                let result = String(format: formatter.localizedIntentsString, details[0].stage!.description.rawValue.localizedIntentsString, details[0].weapons[0].description.rawValue.localizedIntentsString, details[0].weapons[1].description.rawValue.localizedIntentsString, details[0].weapons[2].description.rawValue.localizedIntentsString, details[0].weapons[3].description.rawValue.localizedIntentsString, absoluteLongIntentsTimeSpan(current: Date(), startTime: details[0].startTime, endTime: details[0].endTime))
                
                let encoder = JSONEncoder()
                let data = try! encoder.encode(details[0])
                let activity = NSUserActivity(activityType: "name.sketch.Ikachan.shift")
                activity.userInfo?["shift"] = data.base64EncodedString()
                let response = ShiftIntentResponse.success(result: result)
                response.userActivity = activity
                completion(response)
            } else {
                completion(ShiftIntentResponse(code: .failure, userActivity: nil))
            }
        }
    }
}
