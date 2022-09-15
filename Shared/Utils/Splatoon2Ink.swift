//
//  Splatoon2Ink.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/5.
//

import UIKit
import SwiftyJSON

func fetchSplatoon2Schedules(completion:@escaping ([Splatoon2Schedule]?, Error?) -> Void) {
    do {
        var request = URLRequest(url: URL(string: Splatoon2InkScheduleURL)!)
        request.timeoutInterval = Timeout
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, error)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion(nil, error)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    var result: [Splatoon2Schedule] = []
                    
                    for (_, value) in json {
                        let schedules = value.arrayValue
                        for schedule in schedules {
                            let startTime = Date(timeIntervalSince1970: schedule["start_time"].doubleValue)
                            let endTime = Date(timeIntervalSince1970: schedule["end_time"].doubleValue)
                            let mode = Splatoon2ScheduleMode(rawValue: schedule["game_mode"]["key"].stringValue)!
                            let rule = Splatoon2Rule(rawValue: schedule["rule"]["key"].stringValue)!
                            let stages = [Splatoon2ScheduleStage(rawValue: Int(schedule["stage_a"]["id"].stringValue)!)!, Splatoon2ScheduleStage(rawValue: Int(schedule["stage_b"]["id"].stringValue)!)!]
                            
                            result.append(Splatoon2Schedule(startTime: startTime, endTime: endTime, mode: mode, rule: rule, stages: stages))
                        }
                    }
                    
                    completion(result, error)
                } else {
                    completion(nil, error)
                }
            }
        }
        .resume()
    }
}

func fetchSplatoon2Shifts(completion:@escaping ([Splatoon2Shift]?, Error?) -> Void) {
    do {
        var request = URLRequest(url: URL(string: Splatoon2InkShiftURL)!)
        request.timeoutInterval = Timeout
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, error)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion(nil, error)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    var previousTime = Date(timeIntervalSince1970: 0)
                    var shifts: [Splatoon2Shift] = []
                    
                    let details = json["details"].arrayValue
                    let schedules = json["schedules"].arrayValue
                    for shift in (details + schedules) {
                        let startTime = Date(timeIntervalSince1970: shift["start_time"].doubleValue)
                        if startTime <= previousTime {
                            continue
                        }
                        let endTime = Date(timeIntervalSince1970: shift["end_time"].doubleValue)
                        var stage: Splatoon2ShiftStage?
                        let stageImage = shift["stage"]["image"].string
                        if stageImage != nil {
                            stage = Splatoon2ShiftStage.allCases.first { i in
                                i.image == stageImage
                            }!
                        }
                        var weapons: [Splatoon2Weapon] = []
                        let ws = shift["weapons"].arrayValue
                        for weapon in ws {
                            weapons.append(Splatoon2Weapon(rawValue: Int(weapon["id"].stringValue)!)!)
                        }
                        
                        shifts.append(Splatoon2Shift(startTime: startTime, endTime: endTime, stage: stage, weapons: weapons))
                        
                        previousTime = startTime
                    }
                    
                    completion(shifts, error)
                } else {
                    completion(nil, error)
                }
            }
        }
        .resume()
    }
}
