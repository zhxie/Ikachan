//
//  URL.swift
//  Ikachan
//
//  Created by Sketch on 2021/1/23.
//

import Foundation

extension URL {
    var isDeeplink: Bool {
        return scheme == IkachanScheme
    }
    
    var tab: Tab? {
        guard isDeeplink else {
            return nil
        }

        guard let host = host else {
            return nil
        }
        
        if Schedule.GameMode(rawValue: host) != nil {
            return .schedule
        }
        
        if host == Shift.rawValue {
            return .shift
        }
        
        return nil
    }
    
    var gameMode: Schedule.GameMode? {
        guard isDeeplink else {
            return nil
        }
        
        guard let host = host else {
            return nil
        }
        
        guard let gameMode = Schedule.GameMode(rawValue: host) else {
            return nil
        }

        return gameMode
    }
}
