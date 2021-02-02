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
                completion(ShiftIntentResponse(code: .success, userActivity: nil))
            } else {
                completion(ShiftIntentResponse(code: .failure, userActivity: nil))
            }
        }
    }
}
