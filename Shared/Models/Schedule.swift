//
//  Schedule.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/15.
//

import SwiftUI

struct Stage: Codable {
    var name: String
    var image: URL
    var thumbnail: URL?
}
struct Weapon: Codable {
    var name: String
    var image: URL
    var thumbnail: URL?
}
struct KingSalmonid: Codable {
    var name: String
    var image: String?
}

protocol Schedule {
    var startTime: Date { get }
    var endTime: Date { get }
    var mode: any ScheduleMode { get }
    var rule: any Rule { get }
    var stages: [Stage] { get }
    var challenge: String? { get }
}
protocol Shift {
    var startTime: Date { get }
    var endTime: Date { get }
    var mode: any ShiftMode { get }
    var stage: Stage? { get }
    var weapons: [Weapon]? { get }
    var kingSalmonid: KingSalmonid? { get }
}

struct Splatoon2Schedule: Schedule, Codable {
    var startTime: Date
    var endTime: Date
    var _mode: Splatoon2ScheduleMode
    var _rule: Splatoon2Rule
    var stages: [Stage]
    
    init(startTime: Date, endTime: Date, mode: Splatoon2ScheduleMode, rule: Splatoon2Rule, stages: [Stage]) {
        self.startTime = startTime
        self.endTime = endTime
        _mode = mode
        _rule = rule
        self.stages = stages
    }
    
    var mode: any ScheduleMode {
        return _mode
    }
    var rule: any Rule {
        return _rule
    }
    var challenge: String? {
        return nil
    }
}
struct Splatoon2Shift: Shift, Codable {
    var startTime: Date
    var endTime: Date
    var stage: Stage?
    var weapons: [Weapon]?
    
    var mode: any ShiftMode {
        return Splatoon2ShiftMode.salmonRun
    }
    var kingSalmonid: KingSalmonid? {
        return nil
    }
}
struct Splatoon3Schedule: Schedule, Codable {
    var startTime: Date
    var endTime: Date
    var _mode: Splatoon3ScheduleMode
    var _rule: Splatoon3Rule
    var stages: [Stage]
    var challenge: String?
    
    init(startTime: Date, endTime: Date, mode: Splatoon3ScheduleMode, rule: Splatoon3Rule, stages: [Stage], challenge: String? = nil) {
        self.startTime = startTime
        self.endTime = endTime
        _mode = mode
        _rule = rule
        self.stages = stages
        self.challenge = challenge
    }
    
    var mode: any ScheduleMode {
        return _mode
    }
    var rule: any Rule {
        return _rule
    }
}
struct Splatoon3Shift: Shift, Codable {
    var startTime: Date
    var endTime: Date
    var _mode: Splatoon3ShiftMode
    var _stage: Stage
    var _weapons: [Weapon]
    var kingSalmonid: KingSalmonid?
    
    init(startTime: Date, endTime: Date, mode: Splatoon3ShiftMode, stage: Stage, weapons: [Weapon], kingSalmonid: KingSalmonid? = nil) {
        self.startTime = startTime
        self.endTime = endTime
        _mode = mode
        _stage = stage
        _weapons = weapons
        self.kingSalmonid = kingSalmonid
    }
    
    var mode: any ShiftMode {
        return _mode
    }
    var stage: Stage? {
        return _stage
    }
    var weapons: [Weapon]? {
        return _weapons
    }
}
