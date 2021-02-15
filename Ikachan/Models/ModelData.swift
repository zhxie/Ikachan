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
    
    var isSchedulesUpdating = false
    
    func updateSchedules() {
        if isSchedulesUpdating {
            return
        } else {
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
    }
    
    func loadSchedules(data: Data) -> Bool {
        let json = try? JSON(data: data)
        
        guard let j = json else {
            return false
        }
        
        var schedules: [Schedule] = []
    
        for (_, value) in j {
            let ss = value.arrayValue
            for schedule in ss {
                schedules.append(parseSchedule(schedule: schedule))
            }
        }
    
        self.schedules = schedules
        
        return true
    }
    
    @Published var shifts: [Shift] = []
    
    var isShiftsUpdating = false
    
    func updateShifts() {
        if isShiftsUpdating {
            return
        } else {
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
    }
    
    func loadShifts(data: Data) -> Bool {
        let json = try? JSON(data: data)
        
        guard let j = json else {
            return false
        }
        
        var shifts: [Shift] = []
        
        // Details
        let detailsJSON = j["details"].arrayValue
        for shift in detailsJSON {
            shifts.append(parseShift(shift: shift))
        }
        
        // Schedules
        var schedulesJSON = j["schedules"].arrayValue
        schedulesJSON = schedulesJSON.suffix(schedulesJSON.count - detailsJSON.count)
        for shift in schedulesJSON {
            shifts.append(parseShift(shift: shift))
        }
        
        self.shifts = shifts
        
        return true
    }
}
