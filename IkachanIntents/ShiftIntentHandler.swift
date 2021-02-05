//
//  ShiftIntentHandler.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/3.
//

import Intents

class ShiftIntentHandler: IntentHandler, ShiftIntentHandling {
    func resolveRotation(for intent: ShiftIntent, with completion: @escaping (RotationResolutionResult) -> Void) {
        if intent.rotation == .unknown {
            completion(RotationResolutionResult.confirmationRequired(with: .current))
        } else {
            completion(RotationResolutionResult.success(with: intent.rotation))
        }
    }
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    func handle(intent: ShiftIntent, completion: @escaping (ShiftIntentResponse) -> Void) {
        fetchShifts { (shifts, error) in
            guard let shifts = shifts else {
                completion(ShiftIntentResponse(code: .failure, userActivity: nil))
                
                return
            }
            
            let details = shifts.filter { shift in
                shift.stage != nil
            }
            
            var formatter = ""
            var shift: Shift? = nil
            
            switch intent.rotation {
            case .unknown, .current:
                formatter = "open_shift"
                shift = details.at(index: 0)
            case .next:
                formatter = "next_shift"
                shift = details.at(index: 1)
            }
            
            guard let s = shift else {
                completion(ShiftIntentResponse(code: .failure, userActivity: nil))
                
                return
            }
            
            if formatter == "open_shift" && s.startTime > Date() {
                formatter = "soon_shift"
            }
            
            let result = String(format: formatter.localizedIntentsString, s.stage!.description.rawValue.localizedIntentsString, s.weapons[0].description.rawValue.localizedIntentsString, s.weapons[1].description.rawValue.localizedIntentsString, s.weapons[2].description.rawValue.localizedIntentsString, s.weapons[3].description.rawValue.localizedIntentsString, absoluteLongIntentsTimeSpan(current: Date(), startTime: s.startTime, endTime: s.endTime))
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(s)
            let activity = NSUserActivity(activityType: "name.sketch.Ikachan.shift")
            activity.userInfo?["shift"] = data.base64EncodedString()
            let response = ShiftIntentResponse.success(result: result, rotation: intent.rotation)
            response.userActivity = activity
            completion(response)
        }
    }
}
