//
//  ModelData.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/16.
//

import Foundation
import SwiftyJSON

final class ModelData: ObservableObject {
    @Published var schedules: [Schedule] = []
    @Published var shifts: [Shift] = []
    
    var isSchedulesUpdating = false
    var isShiftsUpdating = false
    
    func updateSplatoon2Schedules() {
        if isSchedulesUpdating {
            return
        } else {
            isSchedulesUpdating = true
            
            fetchSplatoon2Schedules { (schedules, error) in
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
    func updateSplatoon2Shifts() {
        if isShiftsUpdating {
            return
        } else {
            isShiftsUpdating = true
            
            fetchSplatoon2Shifts { (shifts, error) in
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
}
