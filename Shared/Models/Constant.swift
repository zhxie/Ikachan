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

let SchedulePlaceholder = Schedule(startTime: Date(timeIntervalSince1970: 0), endTime: Date(timeIntervalSince1970: 7200), gameMode: .regular, rule: .turfWar, stageA: Schedule.Stage(id: .theReef, image: ""), stageB: Schedule.Stage(id: .musselforgeFitness, image: ""))
let ShiftPlaceholder = Shift(startTime: Date(timeIntervalSince1970: 30672000), endTime: Date(timeIntervalSince1970: 30736800), stage: Shift.Stage(id: .spawningGrounds), weapons: [Weapon(id: .random, image: ""), Weapon(id: .random, image: ""), Weapon(id: .random, image: ""), Weapon(id: .random, image: "")])

let IkachanScheme = "ikachan"
let IkachanActivity = "name.sketch.Ikachan"
let IkachanSchedulesActivity = IkachanActivity + ".schedules"
let IkachanShiftsActivity = IkachanActivity + ".shifts"

// Widget
let MaxWidgetEntryCount = 60

