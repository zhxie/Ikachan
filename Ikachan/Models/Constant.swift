//
//  Constant.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/17.
//

import Foundation
import SwiftUI

let Splatoon2InkURL = "https://splatoon2.ink"

let Splatoon2InkScheduleURL = Splatoon2InkURL + "/data/schedules.json"
let Splatoon2InkShiftURL = Splatoon2InkURL + "/data/coop-schedules.json"

let Splatnet2URL = "https://app.splatoon2.nintendo.net"

let SchedulePlaceholder = Schedule(startTime: Date(timeIntervalSince1970: 0), endTime: Date(timeIntervalSince1970: 7200), gameMode: Schedule.GameMode.regular, rule: Schedule.Rule.turfWar, stageA: Schedule.Stage(id: Schedule.StageId.theReef, image: ""), stageB: Schedule.Stage(id: Schedule.StageId.musselforgeFitness, image: ""))
let ShiftPlaceholder = Shift(startTime: Date(timeIntervalSince1970: 30672000), endTime: Date(timeIntervalSince1970: 30736800), stage: Shift.Stage(image: Shift.StageImage.spawningGrounds), weapons: [Weapon(id: Weapon.WeaponId.random, image: ""), Weapon(id: Weapon.WeaponId.random, image: ""), Weapon(id: Weapon.WeaponId.random, image: ""), Weapon(id: Weapon.WeaponId.random, image: "")])

let Timeout = 60.0

let IPhone12ProMaxSmallWidgetSafeWidth: CGFloat = 137.0
/// Any small widget with width under `CompactSmallWidgetSafeWidth` will be displayed as a compact widget.
let CompactSmallWidgetSafeWidth: CGFloat = 130.0
/// Any medium widget with width under `CompactMediumWidgetSafeWidth` will be deplayed as a compact widget.
let CompactMediumWidgetSafeWidth: CGFloat = 286.0
let ComponentMinWidth: CGFloat = 364.0

let IkachanScheme = "ikachan"

let MaxWidgetEntryCount = 60
