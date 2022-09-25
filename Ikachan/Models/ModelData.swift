//
//  ModelData.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/16.
//

import Foundation
import SwiftyJSON

enum Tab {
    case schedule
    case shift
    case about
}

final class ModelData: ObservableObject {
    @Published var tab: Tab = .schedule
    @Published var game: Game = .splatoon3
    @Published var mode = "regular_battle"
    @Published var rule = ""
    
    @Published var schedules: [Schedule] = []
    @Published var shifts: [Shift] = []
    
    var isSchedulesUpdating = false
    var isShiftsUpdating = false

    func updateSchedules() {
        if isSchedulesUpdating {
            return
        } else {
            isSchedulesUpdating = true
            
            fetchSchedules(game: game) { schedules, _, error in
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
    
    func changeGame() {
        switch game {
        case .splatoon2:
            changeGame(game: .splatoon3)
        case .splatoon3:
            changeGame(game: .splatoon2)
        }
    }
    func changeGame(game: Game) {
        switch game {
        case .splatoon2:
            self.game = .splatoon2
            mode = "regular_battle"
            rule = ""
        case .splatoon3:
            self.game = .splatoon3
            mode = "regular_battle"
            rule = ""
        }
    }
}
