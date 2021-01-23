//
//  Shift.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/16.
//

import Foundation
import SwiftUI

struct Shift: Hashable, Codable {
    var startTime: Date
    var endTime: Date
    
    var stage: Stage?
    struct Stage: Hashable, Codable {
        var image: StageImage
        
        var description: LocalizedStringKey {
            switch self.image {
            case .spawningGrounds:
                return "spawning_grounds"
            case .maroonersBay:
                return "marooners_bay"
            case .lostOutpost:
                return "lost_outpost"
            case .salmonidSmokeyard:
                return "salmonid_smokeyard"
            case .ruinsOfArkPolaris:
                return "ruins_of_ark_polaris"
            }
        }
    }
    
    enum StageImage: String, CaseIterable, Codable {
        case spawningGrounds = "/images/coop_stage/65c68c6f0641cc5654434b78a6f10b0ad32ccdee.png"
        case maroonersBay = "/images/coop_stage/e07d73b7d9f0c64e552b34a2e6c29b8564c63388.png"
        case lostOutpost = "/images/coop_stage/6d68f5baa75f3a94e5e9bfb89b82e7377e3ecd2c.png"
        case salmonidSmokeyard = "/images/coop_stage/e9f7c7b35e6d46778cd3cbc0d89bd7e1bc3be493.png"
        case ruinsOfArkPolaris = "/images/coop_stage/50064ec6e97aac91e70df5fc2cfecf61ad8615fd.png"
    }
    
    var weapons: [Weapon]
    
    static let subURL = "salmon_run"
    static let url = IkachanScheme + "://" + subURL
}
