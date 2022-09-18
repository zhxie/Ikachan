//
//  ModelData.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/16.
//

import Foundation
import SwiftyJSON

final class ModelData: ObservableObject {
    @Published var game: Game = .splatoon3
    
    @Published var schedules: [Schedule] = []
    @Published var shifts: [Shift] = []
    
    var isSchedulesUpdating = false
    var isShiftsUpdating = false

    func updateSchedules() {
        if isSchedulesUpdating {
            return
        } else {
            isSchedulesUpdating = true
            
            fetchSchedules(game: game) { schedules, error in
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
    func updateShifts() {
        if isShiftsUpdating {
            return
        } else {
            isShiftsUpdating = true
            
            fetchShifts(game: game) { shifts, error in
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
