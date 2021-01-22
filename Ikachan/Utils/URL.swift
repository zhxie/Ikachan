//
//  URL.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/23.
//

import Foundation

enum TabIdentifier {
    case schedule
    case shift
}

extension URL {
    var isDeeplink: Bool {
        return scheme == IkachanScheme
    }
    
    var tabIdentifier: TabIdentifier? {
        guard isDeeplink else {
            return nil
        }
        
        switch host {
        case IkachanScheduleSubScheme:
            return .schedule
        case IkachanShiftSubScheme:
            return .shift
        default:
            return nil
        }
    }
}
