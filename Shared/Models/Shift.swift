//
//  Shift.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/16.
//

import SwiftUI

protocol Shift: Codable {
    var startTime: Date { get set }
    var endTime: Date { get set }
    var rule: ShiftRule { get }
    var stage: Stage? { get }
    var weapons: [Weapon] { get }
}

struct Splatoon2Shift: Shift {
    private var _stage: Splatoon2ShiftStage?
    private var _weapons: [Splatoon2Weapon]
    
    init(startTime: Date, endTime: Date, stage: Splatoon2ShiftStage?, weapons: [Splatoon2Weapon]) {
        self.startTime = startTime
        self.endTime = endTime
        _stage = stage
        _weapons = weapons
    }
    
    var startTime: Date
    var endTime: Date
    var rule: ShiftRule {
        return Splatoon2ShiftRule.salmonRun
    }
    var stage: Stage? {
        return _stage
    }
    var weapons: [Weapon] {
        return _weapons
    }
}

struct Splatoon3Shift: Shift {
    private var _rule: Splatoon3ShiftRule
    private var _stage: Splatoon3ShiftStage?
    private var _weapons: [Splatoon3Weapon]
    
    init(startTime: Date, endTime: Date, rule: Splatoon3ShiftRule, stage: Splatoon3ShiftStage?, weapons: [Splatoon3Weapon]) {
        self.startTime = startTime
        self.endTime = endTime
        _rule = rule;
        _stage = stage
        _weapons = weapons
    }
    
    var startTime: Date
    var endTime: Date
    var rule: ShiftRule {
        return _rule
    }
    var stage: Stage? {
        return _stage
    }
    var weapons: [Weapon] {
        return _weapons
    }
}
