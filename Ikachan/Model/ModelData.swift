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
    @Published var regularScheduleModelData = ScheduleModelData(gameMode: Schedule.GameMode.regular)
    @Published var rankedScheduleModelData = ScheduleModelData(gameMode: Schedule.GameMode.gachi)
    @Published var leagueScheduleModelData = ScheduleModelData(gameMode: Schedule.GameMode.league)
    @Published var shiftModelData = ShiftModelData()
}

final class ScheduleModelData: ObservableObject {
    static let RequestURL = "https://splatoon2.ink/data/schedules.json"
    
    init(gameMode: Schedule.GameMode) {
        self.gameMode = gameMode
    }
    
    var gameMode: Schedule.GameMode
    
    @Published var schedules: [Schedule] = []

    @Published var isUpdating = false

    func update() {
        if isUpdating {
            return
        }
        
        isUpdating = true
        
        var request = URLRequest(url: URL(string: ScheduleModelData.RequestURL)!)
        request.timeoutInterval = 5
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                self.isUpdating = false
                return
            }
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                self.isUpdating = false
                return
            }
            
            do {
                let json = try JSON(data: data!)
                
                var schedules: [Schedule] = []
                
                let ss = json[self.gameMode.rawValue].arrayValue
                for schedule in ss {
                    schedules.append(self.parseSchedule(schedule: schedule))
                }
                
                self.schedules = schedules
                
                self.isUpdating = false
            } catch {
                self.isUpdating = false
                return
            }
        }.resume()
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
}

final class ShiftModelData: ObservableObject {
    static let RequestURL = "https://splatoon2.ink/data/coop-schedules.json"
    
    @Published var shifts: [Shift] = []
    
    @Published var isUpdating = false
    
    func update() {
        if isUpdating {
            return
        }
        
        isUpdating = true
        
        var request = URLRequest(url: URL(string: ShiftModelData.RequestURL)!)
        request.timeoutInterval = 5
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                self.isUpdating = false
                return
            }
            
            let response = response as! HTTPURLResponse
            let status = response.statusCode
            guard (200...299).contains(status) else {
                self.isUpdating = false
                return
            }
            
            do {
                let json = try JSON(data: data!)
                
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
                
                self.isUpdating = false
            } catch {
                self.isUpdating = false
                return
            }
        }.resume()
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
