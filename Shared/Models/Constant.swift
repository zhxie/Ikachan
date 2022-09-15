//
//  Constant.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/17.
//

import SwiftUI

let Splatnet2URL = "https://app.splatoon2.nintendo.net"
let Splatoon2InkURL = "https://splatoon2.ink"
let Splatoon2InkScheduleURL = Splatoon2InkURL + "/data/schedules.json"
let Splatoon2InkShiftURL = Splatoon2InkURL + "/data/coop-schedules.json"

let Timeout: Double = 60

let SchedulePlaceholder = Splatoon2Schedule(startTime: Date(timeIntervalSince1970: 0), endTime: Date(timeIntervalSince1970: 7200), mode: .regular, rule: .turfWar, stages: [.theReef, .musselforgeFitness])
let ShiftPlaceholder = Splatoon2Shift(startTime: Date(timeIntervalSince1970: 30672000), endTime: Date(timeIntervalSince1970: 30736800), stage: .spawningGrounds, weapons: [.random, .random, .random, .random])

let IkachanScheme = "ikachan"
let IkachanActivity = "name.sketch.Ikachan"
let IkachanSchedulesActivity = IkachanActivity + ".schedules"
let IkachanShiftsActivity = IkachanActivity + ".shifts"

// Widget
let MaxWidgetEntryCount = 60

