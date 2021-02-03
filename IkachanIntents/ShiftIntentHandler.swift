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
                
                let result = String(format: formatter.localizedStringForSiri, details[0].stage!.description.rawValue.localizedStringForSiri, details[0].weapons[0].description.rawValue.localizedStringForSiri, details[0].weapons[1].description.rawValue.localizedStringForSiri, details[0].weapons[2].description.rawValue.localizedStringForSiri, details[0].weapons[3].description.rawValue.localizedStringForSiri, ShiftIntentHandler.timeSpan(current: Date(), startTime: details[0].startTime, endTime: details[0].endTime))
                
                completion(ShiftIntentResponse.success(result: result))
            } else {
                completion(ShiftIntentResponse(code: .failure, userActivity: nil))
            }
        }
    }
    
    private static func timeSpan(current: Date, startTime: Date, endTime: Date) -> String {
        if current >= startTime {
            return format(interval: endTime - current)
        } else {
            return format(interval: current - startTime)
        }
    }
    
    private static func format(interval: TimeInterval) -> String {
        let mins = Int((interval / 60).rounded())
        
        let min = mins % 60
        let hour = (mins % 1440) / 60
        let day = mins / 1440
        
        var result = String(format: "%d_min".localizedStringForSiri, min)
        
        if hour > 0 {
            result = String(format: "%d_hour_%@".localizedStringForSiri, hour, result)
        }
        
        if day > 0 {
            result = String(format: "%d_day_%@".localizedStringForSiri, day, result)
        }
        
        return result
    }
}
