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

let SchedulePlaceholder = Schedule(startTime: Date(timeIntervalSince1970: 0), endTime: Date(timeIntervalSince1970: 0), gameMode: Schedule.GameMode.regular, rule: Schedule.Rule.turfWar, stageA: Schedule.Stage(id: Schedule.StageId.theReef, image: "/images/stage/98baf21c0366ce6e03299e2326fe6d27a7582dce.png"), stageB: Schedule.Stage(id: Schedule.StageId.musselforgeFitness, image: "/images/stage/83acec875a5bb19418d7b87d5df4ba1e38ceac66.png"))
let ShiftPlaceholder = Shift(startTime: Date(timeIntervalSince1970: 0), endTime: Date(timeIntervalSince1970: 0), stage: Shift.Stage(image: Shift.StageImage.lostOutpost), weapons: [Weapon(id: Weapon.WeaponId.random, image: "/images/coop_weapons/746f7e90bc151334f0bf0d2a1f0987e311b03736.png"), Weapon(id: Weapon.WeaponId.random, image: "/images/coop_weapons/746f7e90bc151334f0bf0d2a1f0987e311b03736.png"), Weapon(id: Weapon.WeaponId.random, image: "/images/coop_weapons/746f7e90bc151334f0bf0d2a1f0987e311b03736.png"), Weapon(id: Weapon.WeaponId.random, image: "/images/coop_weapons/746f7e90bc151334f0bf0d2a1f0987e311b03736.png")])

let Timeout = 60.0

let DownscaledSystemSmallWidgetWithPadding: CGFloat = 126.0
let DownscaledSystemMediumWidgetWithPadding: CGFloat = 126.0

let IkachanScheme = "ikachan"
