//
//  Constant.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/17.
//

import Foundation
import SwiftUI

let Splatnet2URL = "https://app.splatoon2.nintendo.net"

let Splatoon2InkURL = "https://splatoon2.ink"
let Splatoon2InkScheduleURL = Splatoon2InkURL + "/data/schedules.json"
let Splatoon2InkShiftURL = Splatoon2InkURL + "/data/coop-schedules.json"

let Timeout = 60.0

let SchedulePlaceholder = Schedule(startTime: Date(timeIntervalSince1970: 0), endTime: Date(timeIntervalSince1970: 7200), gameMode: .regular, rule: .turfWar, stageA: Schedule.Stage(id: .theReef, image: ""), stageB: Schedule.Stage(id: .musselforgeFitness, image: ""))
let ShiftPlaceholder = Shift(startTime: Date(timeIntervalSince1970: 30672000), endTime: Date(timeIntervalSince1970: 30736800), stage: Shift.Stage(id: .spawningGrounds), weapons: [Weapon(id: .random, image: ""), Weapon(id: .random, image: ""), Weapon(id: .random, image: ""), Weapon(id: .random, image: "")])

let IkachanScheme = "ikachan"
let IkachanActivity = "name.sketch.Ikachan"
let IkachanSchedulesActivity = IkachanActivity + ".schedules"
let IkachanShiftsActivity = IkachanActivity + ".shifts"

// View
let IPhone12ProMaxSmallWidgetSafeWidth: CGFloat = 137.0
/// Any small widget with width under `CompactSmallWidgetSafeWidth` will be displayed as a compact widget.
let CompactSmallWidgetSafeWidth: CGFloat = 130.0
/// Any medium widget with width under `CompactMediumWidgetSafeWidth` will be deplayed as a compact widget.
let CompactMediumWidgetSafeWidth: CGFloat = 286.0
let ComponentMinWidth: CGFloat = 364.0

// Widget
let MaxWidgetEntryCount = 60

