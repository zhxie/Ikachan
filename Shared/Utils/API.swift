//
//  Splatoon2Ink.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/5.
//

import UIKit
import SwiftyJSON

private func fetchSplatoon2Schedules(completion: @escaping ([Splatoon2Schedule]?, Error?) -> Void) {
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
                    var schedules: [Splatoon2Schedule] = []
                    
                    for (_, value) in json {
                        for schedule in value.arrayValue {
                            let startTime = Date(timeIntervalSince1970: schedule["start_time"].doubleValue)
                            let endTime = Date(timeIntervalSince1970: schedule["end_time"].doubleValue)
                            let mode = Splatoon2ScheduleMode(rawValue: schedule["game_mode"]["key"].stringValue)!
                            let rule = Splatoon2Rule(rawValue: schedule["rule"]["key"].stringValue) ?? .unknown
                            let stages = [Splatoon2ScheduleStage(rawValue: Int(schedule["stage_a"]["id"].stringValue)!) ?? .unknown, Splatoon2ScheduleStage(rawValue: Int(schedule["stage_b"]["id"].stringValue)!) ?? .unknown]
                            
                            schedules.append(Splatoon2Schedule(startTime: startTime, endTime: endTime, mode: mode, rule: rule, stages: stages))
                        }
                    }
                    
                    completion(schedules, error)
                } else {
                    completion(nil, error)
                }
            }
        }
        .resume()
    }
}
private func fetchSplatoon2Shifts(completion: @escaping ([Splatoon2Shift]?, Error?) -> Void) {
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
                    
                    for shift in (json["details"].arrayValue + json["schedules"].arrayValue) {
                        let startTime = Date(timeIntervalSince1970: shift["start_time"].doubleValue)
                        if startTime <= previousTime {
                            continue
                        }
                        let endTime = Date(timeIntervalSince1970: shift["end_time"].doubleValue)
                        var stage: Splatoon2ShiftStage?
                        let stageImage = shift["stage"]["image"].string
                        if stageImage != nil {
                            stage = Splatoon2ShiftStage.allCases.first { stage in
                                stage.image == stageImage
                            } ?? .unknown
                        }
                        var weapons: [Splatoon2Weapon] = []
                        for weapon in shift["weapons"].arrayValue {
                            weapons.append(Splatoon2Weapon(rawValue: Int(weapon["id"].stringValue)!) ?? .unknown)
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
private func fetchSplatoon3Schedules(completion: @escaping ([Splatoon3Schedule]?, Splatoon3Splatfest?, Error?) -> Void) {
    do {
        var request = URLRequest(url: URL(string: Splatoon3InkScheduleURL)!)
        request.timeoutInterval = Timeout
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(nil, nil, error)
            } else {
                let response = response as! HTTPURLResponse
                let status = response.statusCode
                guard (200...299).contains(status) else {
                    completion(nil, nil, error)
                    
                    return
                }
                
                if let json = try? JSON(data: data!) {
                    var schedules: [Splatoon3Schedule] = []
                    
                    let innerData = json["data"]
                    for schedule in innerData["regularSchedules"]["nodes"].arrayValue {
                        let startTime = utcToDate(date: schedule["startTime"].stringValue)
                        let endTime = utcToDate(date: schedule["endTime"].stringValue)
                        let matchSetting = schedule["regularMatchSetting"]
                        if matchSetting.isNull {
                            continue
                        }
                        let rule = Splatoon3Rule(rawValue: matchSetting["vsRule"]["rule"].stringValue.lowercased()) ?? .unknown
                        var stages: [Splatoon3ScheduleStage] = []
                        for stage in matchSetting["vsStages"].arrayValue {
                            stages.append(Splatoon3ScheduleStage(rawValue: stage["vsStageId"].intValue) ?? .unknown)
                        }
                        
                        schedules.append(Splatoon3Schedule(startTime: startTime, endTime: endTime, mode: .regular, rule: rule, stages: stages))
                    }
                    for schedule in innerData["bankaraSchedules"]["nodes"].arrayValue {
                        let startTime = utcToDate(date: schedule["startTime"].stringValue)
                        let endTime = utcToDate(date: schedule["endTime"].stringValue)
                        for matchSetting in schedule["bankaraMatchSettings"].arrayValue {
                            if matchSetting.isNull {
                                continue
                            }
                            let mode = Splatoon3ScheduleMode(rawValue: matchSetting["mode"].stringValue.lowercased())!
                            let rule = Splatoon3Rule(rawValue: matchSetting["vsRule"]["rule"].stringValue.lowercased()) ?? .unknown
                            var stages: [Splatoon3ScheduleStage] = []
                            for stage in matchSetting["vsStages"].arrayValue {
                                stages.append(Splatoon3ScheduleStage(rawValue: stage["vsStageId"].intValue) ?? .unknown)
                            }
                            
                            schedules.append(Splatoon3Schedule(startTime: startTime, endTime: endTime, mode: mode, rule: rule, stages: stages))
                        }
                    }
                    
                    var fest: Splatoon3Splatfest? = nil
                    let currentFest = innerData["currentFest"]
                    if !currentFest.isNull {
                        let startTime = utcToDate(date: currentFest["startTime"].stringValue)
                        let midtermTime = utcToDate(date: currentFest["midtermTime"].stringValue)
                        let endTime = utcToDate(date: currentFest["endTime"].stringValue)
                        let state = Splatoon3Splatfest.State(rawValue: currentFest["state"].stringValue.lowercased())!
                        let stageImage = currentFest["tricolorStage"]["image"]["url"].stringValue
                        let stage = Splatoon3ScheduleStage.allCases.first { stage in
                            stageImage.hasSuffix(stage.image.replacingOccurrences(of: "_0", with: "_1"))
                        } ?? .unknown
                        fest = Splatoon3Splatfest(startTime: startTime, midtermTime: midtermTime, endTime: endTime, state: state, stage: stage)
                    }
                    for schedule in innerData["festSchedules"]["nodes"].arrayValue {
                        let startTime = utcToDate(date: schedule["startTime"].stringValue)
                        let endTime = utcToDate(date: schedule["endTime"].stringValue)
                        let matchSetting = schedule["festMatchSetting"]
                        if matchSetting.isNull {
                            continue
                        }
                        let rule = Splatoon3Rule(rawValue: matchSetting["vsRule"]["rule"].stringValue.lowercased()) ?? .unknown
                        var stages: [Splatoon3ScheduleStage] = []
                        for stage in matchSetting["vsStages"].arrayValue {
                            stages.append(Splatoon3ScheduleStage(rawValue: stage["vsStageId"].intValue) ?? .unknown)
                        }
                        
                        schedules.append(Splatoon3Schedule(startTime: startTime, endTime: endTime, mode: .regular, rule: rule, stages: stages))
                    }

                    schedules.sort { a, b in
                        a.startTime < b.startTime
                    }
                    completion(schedules, fest, error)
                } else {
                    completion(nil, nil, error)
                }
            }
        }
        .resume()
    }
}
private func fetchSplatoon3Shifts(completion: @escaping ([Splatoon3Shift]?, Error?) -> Void) {
    do {
        var request = URLRequest(url: URL(string: Splatoon3InkScheduleURL)!)
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
                    var shifts: [Splatoon3Shift] = []
                    
                    for shift in json["data"]["coopGroupingSchedule"]["regularSchedules"]["nodes"].arrayValue {
                        let startTime = utcToDate(date: shift["startTime"].stringValue)
                        let endTime = utcToDate(date: shift["endTime"].stringValue)
                        let setting = shift["setting"]
                        let stage = Splatoon3ShiftStage(rawValue: setting["coopStage"]["coopStageId"].intValue) ?? .unknown
                        var weapons: [Splatoon3Weapon] = []
                        for weapon in setting["weapons"].arrayValue {
                            weapons.append(Splatoon3Weapon.allCases.first { w in
                                w.imageUrl == weapon["image"]["url"].stringValue
                            } ?? .unknown)
                        }
                        
                        shifts.append(Splatoon3Shift(startTime: startTime, endTime: endTime, stage: stage, weapons: weapons))
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

func fetchSchedules(game: Game, completion: @escaping ([Schedule]?, Splatfest?, Error?) -> Void) {
    switch game {
    case .splatoon2:
        return fetchSplatoon2Schedules { schedules, error in
            completion(schedules, nil, error)
        }
    case .splatoon3:
        return fetchSplatoon3Schedules(completion: completion)
    }
}
func fetchShifts(game: Game, completion: @escaping ([Shift]?, Error?) -> Void) {
    switch game {
    case .splatoon2:
        return fetchSplatoon2Shifts(completion: completion)
    case .splatoon3:
        return fetchSplatoon3Shifts(completion: completion)
    }
}
