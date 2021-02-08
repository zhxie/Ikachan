//
//  Splatoon2Ink.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/5.
//

import Foundation
import SwiftyJSON

func fetchSchedules(completion:@escaping ([Schedule]?, Error?) -> Void) {
    do {
        var request = URLRequest(url: URL(string: Splatoon2InkScheduleURL)!)
        request.timeoutInterval = Timeout
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, error)
                
                return
            }
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                completion(nil, error)
                
                return
            }
            
            if let json = try? JSON(data: data!) {
                var schedules: [Schedule] = []
                
                for (_, value) in json {
                    let ss = value.arrayValue
                    for schedule in ss {
                        schedules.append(parseSchedule(schedule: schedule))
                    }
                }
                
                completion(schedules, error)
            } else {
                completion(nil, error)
                
                return
            }
        }
        .resume()
    }
}

func parseSchedule(schedule: JSON) -> Schedule {
    let startTime = schedule["start_time"].doubleValue
    let endTime = schedule["end_time"].doubleValue
    let gameMode = schedule["game_mode"]["key"].stringValue
    let rule = schedule["rule"]["key"].stringValue
    
    let stage_a_id = Int(schedule["stage_a"]["id"].stringValue)!
    let stage_a_image = schedule["stage_a"]["image"].stringValue
    
    let stage_b_id = Int(schedule["stage_b"]["id"].stringValue)!
    let stage_b_image = schedule["stage_b"]["image"].stringValue
    
    return Schedule(startTime: Date(timeIntervalSince1970: startTime), endTime: Date(timeIntervalSince1970: endTime), gameMode: Schedule.GameMode(rawValue: gameMode)!, rule: Schedule.Rule(rawValue: rule)!, stageA: Schedule.Stage(id: Schedule.Stage.StageId(rawValue: stage_a_id)!, image: stage_a_image), stageB: Schedule.Stage(id: Schedule.Stage.StageId(rawValue: stage_b_id)!, image: stage_b_image))
}

func fetchShifts(completion:@escaping ([Shift]?, Error?) -> Void) {
    do {
        var request = URLRequest(url: URL(string: Splatoon2InkShiftURL)!)
        request.timeoutInterval = Timeout
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, error)
                
                return
            }
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                completion(nil, error)
                
                return
            }
            
            if let json = try? JSON(data: data!) {
                var shifts: [Shift] = []
                
                // Details
                let detailsJSON = json["details"].arrayValue
                for shift in detailsJSON {
                    shifts.append(parseShift(shift: shift))
                }
                
                // Schedules
                var schedulesJSON = json["schedules"].arrayValue
                schedulesJSON = schedulesJSON.suffix(schedulesJSON.count - detailsJSON.count)
                for shift in schedulesJSON {
                    shifts.append(parseShift(shift: shift))
                }
                
                completion(shifts, error)
            } else {
                completion(nil, error)
                
                return
            }
        }
        .resume()
    }
}

func parseShift(shift: JSON) -> Shift {
    let startTime = shift["start_time"].doubleValue
    let endTime = shift["end_time"].doubleValue
    
    let stage_image = shift["stage"]["image"].string
    
    var weapons: [Weapon] = []
    if stage_image != nil {
        let ws = shift["weapons"].arrayValue
        for w in ws {
            weapons.append(parseWeapon(weapon: w))
        }
    }
    
    return Shift(startTime: Date(timeIntervalSince1970: startTime), endTime: Date(timeIntervalSince1970: endTime), stage: parseShiftStage(stageImage: stage_image), weapons: weapons)
}

func parseShiftStage(stageImage: String?) -> Shift.Stage? {
    guard let stageImage = stageImage else {
        return nil
    }
    
    return Shift.Stage(image: Shift.Stage.StageImage(rawValue: stageImage)!)
}

func parseWeapon(weapon: JSON) -> Weapon {
    let id = Int(weapon["id"].stringValue)!
    var image = weapon["weapon"]["image"].string
    if image == nil {
        image = weapon["coop_special_weapon"]["image"].string
    }
    
    return Weapon(id: Weapon.WeaponId(rawValue: id)!, image: image!)
}
