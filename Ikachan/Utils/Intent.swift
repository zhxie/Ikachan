//
//  Intent.swift
//  Ikachan
//
//  Created by Sketch on 2021/12/3.
//

import Foundation
import Intents

func donate(tab: Tab, gameMode: Schedule.GameMode) {
    switch tab {
    case .schedule:
        return donateSchedule(gameMode: gameMode)
    case .shift:
        return donateShift()
    }
}

func donateSchedule(gameMode: Schedule.GameMode) {
    let intent = ScheduleIntent()
    intent.gameMode = ScheduleIntentHandler.gameModeConvertFrom(gameMode: gameMode)
    intent.rotation = .current
    
    INInteraction(intent: intent, response: nil).donate(completion: nil)
}

func donateShift() {
    let intent = ShiftIntent()
    intent.rotation = .current
    
    INInteraction(intent: intent, response: nil).donate(completion: nil)
}
