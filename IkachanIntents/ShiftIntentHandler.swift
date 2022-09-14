//
//  ShiftIntentHandler.swift
//  IkachanIntents
//
//  Created by Sketch on 2021/2/3.
//

import Intents

class ShiftIntentHandler: IntentHandler, ShiftIntentHandling {
    func resolveRotation(for intent: ShiftIntent, with completion: @escaping (RotationResolutionResult) -> Void) {
        if intent.rotation == .unknown {
            completion(RotationResolutionResult.needsValue())
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
            
            guard let shift = details.at(index: IntentHandler.rotationConvertTo(rotation: intent.rotation)) else {
                completion(ShiftIntentResponse(code: .failure, userActivity: nil))
                
                return
            }
            
            var formatter = ""
            switch intent.rotation {
            case .unknown, .current:
                if shift.startTime > Date() {
                    formatter = "soon_shift"
                } else {
                    formatter = "open_shift"
                }
            case .next:
                formatter = "next_shift"
            }
            
            let result = String(format: formatter.localizedIntentsString, shift.stage!.description.localizedIntentsString, shift.weapons[0].description.localizedIntentsString, shift.weapons[1].description.localizedIntentsString, shift.weapons[2].description.localizedIntentsString, shift.weapons[3].description.localizedIntentsString, intentsLongTimeSpan(current: Date(), startTime: shift.startTime, endTime: shift.endTime))
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(shift)
            let activity = NSUserActivity(activityType: IkachanShiftsActivity)
            activity.userInfo?["shift"] = data.base64EncodedString()
            let response = ShiftIntentResponse.success(result: result)
            response.rotation = intent.rotation
            response.userActivity = activity
            completion(response)
        }
    }
}
