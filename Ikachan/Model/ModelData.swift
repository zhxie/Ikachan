//
//  ModelData.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/16.
//

import Foundation
import Combine
import SwiftyJSON


final class ModelData: ObservableObject {
    @Published var schedules: [Schedule] = []
    
    @Published var isSchedulesUpdating = false
    
    func updateSchedules() {
        if isSchedulesUpdating {
            return
        }
        
        isSchedulesUpdating = true
        
        var request = URLRequest(url: URL(string: Splatoon2InkScheduleURL)!)
        request.timeoutInterval = 5
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    self.isSchedulesUpdating = false
                }
                
                return
            }
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                DispatchQueue.main.async {
                    self.isSchedulesUpdating = false
                }
                
                return
            }
        
            DispatchQueue.main.async {
                if !self.loadSchedules(data: data!) {
                    self.isSchedulesUpdating = false
                    
                    return
                }
                
                self.isSchedulesUpdating = false
            }
        }.resume()
    }
    
    func loadSchedules(data: Data) -> Bool {
        let json = try? JSON(data: data)
        
        if let json = json {
            var schedules: [Schedule] = []
        
            for (_, value) in json {
                let ss = value.arrayValue
                for schedule in ss {
                    schedules.append(parseSchedule(schedule: schedule))
                }
            }
        
            self.schedules = schedules
            
            return true
        } else {
            return false
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
        
        return Schedule(startTime: Date(timeIntervalSince1970: startTime), endTime: Date(timeIntervalSince1970: endTime), gameMode: Schedule.GameMode(rawValue: gameMode)!, rule: Schedule.Rule(rawValue: rule)!, stageA: Schedule.Stage(id: Schedule.StageId(rawValue: stage_a_id)!, image: stage_a_image), stageB: Schedule.Stage(id: Schedule.StageId(rawValue: stage_b_id)!, image: stage_b_image))
    }

    @Published var shifts: [Shift] = []
    
    @Published var isShiftsUpdating = false
    
    func updateShifts() {
        if isShiftsUpdating {
            return
        }
        
        isShiftsUpdating = true
        
        var request = URLRequest(url: URL(string: Splatoon2InkShiftURL)!)
        request.timeoutInterval = 5
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    self.isShiftsUpdating = false
                }
                
                return
            }
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                DispatchQueue.main.async {
                    self.isShiftsUpdating = false
                }
                
                return
            }
        
            DispatchQueue.main.async {
                if !self.loadShifts(data: data!) {
                    self.isShiftsUpdating = false
                    
                    return
                }
                
                self.isShiftsUpdating = false
            }
        }.resume()
    }
    
    func loadShifts(data: Data) -> Bool {
        let json = try? JSON(data: data)
        
        if let json = json {
            var shifts: [Shift] = []
            
            // Details
            let detailsJSON = json["details"].arrayValue
            for shift in detailsJSON {
                shifts.append(self.parseShift(shift: shift))
            }
            
            // Schedules
            let schedulesJSON = json["schedules"].arrayValue
            for shift in schedulesJSON {
                shifts.append(self.parseShift(shift: shift))
            }
            
            self.shifts = shifts
            
            return true
        } else {
            return false
        }
    }
    
    func parseShift(shift: JSON) -> Shift {
        let startTime = shift["start_time"].doubleValue
        let endTime = shift["end_time"].doubleValue
        
        let stage_image = shift["stage"]["image"].string
        
        var weapons: [Weapon] = []
        if let ws = shift["weapons"].arrayObject {
            let ws = ws as! [JSON]
            for w in ws {
                weapons.append(parseWeapon(weapon: w))
            }
        }
        
        return Shift(startTime: Date(timeIntervalSince1970: startTime), endTime: Date(timeIntervalSince1970: endTime), stage: parseStage(stage_image: stage_image), weapons: weapons)
    }
    
    func parseStage(stage_image: String?) -> Shift.Stage? {
        if stage_image == nil {
            return nil
        }
        
        let stage_image = stage_image!
        
        return Shift.Stage(image: Shift.StageImage(rawValue: stage_image)!)
    }
    
    func parseWeapon(weapon: JSON) -> Weapon {
        let id = Int(weapon["id"].stringValue)!
        var image = weapon["weapon"]["image"].string
        if image == nil {
            image = weapon["coop_special_weapon"]["image"].string
        }
        
        return Weapon(id: Weapon.WeaponId(rawValue: id)!, image: image!)
    }
}
