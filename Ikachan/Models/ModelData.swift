//
//  ModelData.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/16.
//

import Foundation
import Combine
import SwiftyJSON

enum Tab {
    case schedule
    case shift
}

final class ModelData: ObservableObject {
    @Published var tab: Tab = .schedule
    @Published var gameMode: Schedule.GameMode = .regular
    
    @Published var schedules: [Schedule] = []
    
    @Published var isSchedulesUpdating = false
    
    func updateSchedules() {
        if isSchedulesUpdating {
            return
        }
        
        isSchedulesUpdating = true
        
        fetchSchedules { (schedules, error) in
            guard let schedules = schedules else {
                DispatchQueue.main.async {
                    self.isSchedulesUpdating = false
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.schedules = schedules
                
                self.isSchedulesUpdating = false
            }
        }
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
    
    @Published var shifts: [Shift] = []
    
    @Published var isShiftsUpdating = false
    
    func updateShifts() {
        if isShiftsUpdating {
            return
        }
        
        isShiftsUpdating = true
        
        fetchShifts { (shifts, error) in
            guard let shifts = shifts else {
                DispatchQueue.main.async {
                    self.isShiftsUpdating = false
                }
                
                return
            }
            
            DispatchQueue.main.async {
                self.shifts = shifts
                
                self.isShiftsUpdating = false
            }
        }
    }
    
    func loadShifts(data: Data) -> Bool {
        let json = try? JSON(data: data)
        
        if let json = json {
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
            
            self.shifts = shifts
            
            return true
        } else {
            return false
        }
    }
}
