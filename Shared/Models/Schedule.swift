//
//  Schedule.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/15.
//

import SwiftUI

protocol Schedule: Codable {
    var startTime: Date { get set }
    var endTime: Date { get set }
    var mode: ScheduleMode { get }
    var rule: Rule { get }
    var stages: [Stage] { get }
    var localizedShorterDescription: String { get }
}

struct Splatoon2Schedule: Schedule {
    private var _mode: Splatoon2ScheduleMode
    private var _rule: Splatoon2ScheduleRule
    private var _stages: [Splatoon2ScheduleStage]
    
    init(startTime: Date, endTime: Date, mode: Splatoon2ScheduleMode, rule: Splatoon2ScheduleRule, stages: [Splatoon2ScheduleStage]) {
        self.startTime = startTime
        self.endTime = endTime
        _mode = mode
        _rule = rule
        _stages = stages
    }
    
    var id: Date {
        return startTime
    }
    var startTime: Date
    var endTime: Date
    var mode: ScheduleMode {
        return _mode
    }
    var rule: Rule {
        return _rule
    }
    var stages: [Stage] {
        return _stages
    }
    var localizedShorterDescription: String {
        switch _mode {
        case .regular:
            return _rule.shortName.localizedString
        case .gachi, .league:
            return String(format: "%@_%@".localizedString, mode.shorterName.localizedString, rule.shorterName.localizedString)
        }
    }
}

struct Splatoon3Schedule: Schedule {
    private var _mode: Splatoon3ScheduleMode
    private var _rule: Splatoon3ScheduleRule
    private var _stages: [Splatoon3ScheduleStage]
    
    init(startTime: Date, endTime: Date, mode: Splatoon3ScheduleMode, rule: Splatoon3ScheduleRule, stages: [Splatoon3ScheduleStage]) {
        self.startTime = startTime
        self.endTime = endTime
        _mode = mode
        _rule = rule
        _stages = stages
    }
    
    var id: Date {
        return startTime
    }
    var startTime: Date
    var endTime: Date
    var mode: ScheduleMode {
        return _mode
    }
    var rule: Rule {
        return _rule
    }
    var stages: [Stage] {
        return _stages
    }
    var localizedShorterDescription: String {
        switch _mode {
        case .regular:
            return _rule.shortName.localizedString
        case .bankaraChallenge, .bankaraOpen, .x:
            return String(format: "%@_%@".localizedString, mode.shorterName.localizedString, rule.shorterName.localizedString)
        }
    }
}
