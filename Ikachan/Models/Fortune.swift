//
//  Fortune.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/6.
//

import Foundation
import SwiftUI

let kujidutsu: [Omikuji] = [
    Omikuji(id: 1, fortune: .greatBlessing, image: "", description: "reach_the_top"),
    Omikuji(id: 2, fortune: .greatBlessing, image: "", description: "find_the_goldie_in_the_first_try"),
    Omikuji(id: 3, fortune: .greatBlessing, image: "", description: "make_friends"),
    Omikuji(id: 4, fortune: .greatBlessing, image: "", description: "keep_the_peace"),
    Omikuji(id: 5, fortune: .middleBlessing, image: "", description: "love_forecast"),
    Omikuji(id: 6, fortune: .middleBlessing, image: "", description: "jellyfishes_go_to_school"),
    Omikuji(id: 7, fortune: .middleBlessing, image: "", description: "clear_with_4_lifesavers"),
    Omikuji(id: 8, fortune: .middleBlessing, image: "", description: "splatfest_100x"),
    Omikuji(id: 9, fortune: .smallBlessing, image: "", description: "telephone_is_ringing"),
    Omikuji(id: 10, fortune: .smallBlessing, image: "", description: "dj_octavio_escaped"),
    Omikuji(id: 11, fortune: .smallBlessing, image: "", description: "mothership_is_sucking_eggs_up"),
    Omikuji(id: 12, fortune: .smallBlessing, image: "", description: "danger_with_chance"),
    Omikuji(id: 13, fortune: .curse, image: "", description: "splatted_by_maws"),
    Omikuji(id: 14, fortune: .curse, image: "", description: "live_sold_out"),
    Omikuji(id: 15, fortune: .curse, image: "", description: "unstable_connection"),
    Omikuji(id: 16, fortune: .curse, image: "", description: "be_careful_of_the_hydra_splatling")
]

struct Omikuji: Identifiable {
    var id: Int
    
    var fortune: Fortune
    enum Fortune: Int, CaseIterable, Codable {
        case greatBlessing = 0
        case middleBlessing = 1
        case smallBlessing = 2
        case curse = 3
        
        var description: LocalizedStringKey {
            switch self {
            case .greatBlessing:
                return "great_blessing"
            case .middleBlessing:
                return "middle_blessing"
            case .smallBlessing:
                return "small_blessing"
            case .curse:
                return "curse"
            }
        }
        
        var defaultImage: String {
            switch self {
            case .greatBlessing, .middleBlessing, .smallBlessing:
                return "inkling.splat"
            case .curse:
                return "inkling.splatted"
            }
        }
    }
    
    var image: String
    
    var description: LocalizedStringKey
}

func fortune() -> Omikuji {
    let uuid = UIDevice.current.identifierForVendor?.uuid
    
    let array: [UInt8] = [uuid?.8 ?? 0, uuid?.9 ?? 0, uuid?.10 ?? 0, uuid?.11 ?? 0, uuid?.12 ?? 0, uuid?.13 ?? 0, uuid?.14 ?? 0, uuid?.15 ?? 0]
    let data = Data(array)
    let id = data.withUnsafeBytes { $0.load(as: Int.self) }
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    let date = Int(formatter.string(from: Date()))!
    
    srand48(id + date)
    
    let index = Int(drand48() * Double(kujidutsu.count))
    
    return kujidutsu[index]
}
