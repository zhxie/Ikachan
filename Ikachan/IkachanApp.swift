//
//  IkachanApp.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/14.
//

import SwiftUI
import Kingfisher

@main
struct IkachanApp: App {
    @StateObject var modelData = ModelData()
    
    init() {
        KingfisherManager.shared.downloader.downloadTimeout = Timeout
        KingfisherManager.shared.cache.diskStorage.config.expiration = .never
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .onOpenURL { url in
                    if let host = url.host {
                        switch host {
                        case "schedule":
                            modelData.tab = .schedule
                            if let game = url.pathComponents.at(index: 1) {
                                if let g = Game.allCases.first(where: { g in
                                    g.name == game
                                }) {
                                    modelData.changeGame(game: g)
                                    if let mode = url.pathComponents.at(index: 2) {
                                        var m: Mode?
                                        switch g {
                                        case .splatoon2:
                                            m = Splatoon2ScheduleMode.allCases.first(where: { m in
                                                m.name == mode
                                            })
                                        case .splatoon3:
                                            m = Splatoon3ScheduleMode.allCases.first(where: { m in
                                                m.name == mode
                                            })
                                        }
                                        if let m = m {
                                            modelData.mode = m.name
                                        }
                                    }
                                }
                            }
                        case "shift":
                            modelData.tab = .shift
                            if let game = url.pathComponents.at(index: 1) {
                                if let g = Game.allCases.first(where: { g in
                                    g.name == game
                                }) {
                                    modelData.changeGame(game: g)
                                }
                            }
                        default:
                            break
                        }
                    }
                }
                .onContinueUserActivity(String(format: IkachanScheduleActivity, Game.splatoon2.name, Splatoon2ScheduleMode.regular.name)) { _ in
                    modelData.tab = .schedule
                    modelData.changeGame(game: .splatoon2)
                    modelData.mode = Splatoon2ScheduleMode.regular.name
                }
                .onContinueUserActivity(String(format: IkachanScheduleActivity, Game.splatoon2.name, Splatoon2ScheduleMode.gachi.name)) { _ in
                    modelData.tab = .schedule
                    modelData.changeGame(game: .splatoon2)
                    modelData.mode = Splatoon2ScheduleMode.gachi.name
                }
                .onContinueUserActivity(String(format: IkachanScheduleActivity, Game.splatoon2.name, Splatoon2ScheduleMode.league.name)) { _ in
                    modelData.tab = .schedule
                    modelData.changeGame(game: .splatoon2)
                    modelData.mode = Splatoon2ScheduleMode.league.name
                }
                .onContinueUserActivity(String(format: IkachanScheduleActivity, Game.splatoon3.name, Splatoon3ScheduleMode.regular.name)) { _ in
                    modelData.tab = .schedule
                    modelData.changeGame(game: .splatoon3)
                    modelData.mode = Splatoon3ScheduleMode.regular.name
                }
                .onContinueUserActivity(String(format: IkachanScheduleActivity, Game.splatoon3.name, Splatoon3ScheduleMode.bankaraChallenge.name)) { _ in
                    modelData.tab = .schedule
                    modelData.changeGame(game: .splatoon3)
                    modelData.mode = Splatoon3ScheduleMode.bankaraChallenge.name
                }
                .onContinueUserActivity(String(format: IkachanScheduleActivity, Game.splatoon3.name, Splatoon3ScheduleMode.bankaraOpen.name)) { _ in
                    modelData.tab = .schedule
                    modelData.changeGame(game: .splatoon3)
                    modelData.mode = Splatoon3ScheduleMode.bankaraOpen.name
                }
                .onContinueUserActivity(String(format: IkachanShiftActivity, Game.splatoon2.name)) { _ in
                    modelData.tab = .shift
                    modelData.changeGame(game: .splatoon2)
                }
                .onContinueUserActivity(String(format: IkachanShiftActivity, Game.splatoon3.name)) { _ in
                    modelData.tab = .shift
                    modelData.changeGame(game: .splatoon3)
                }
        }
    }
}
