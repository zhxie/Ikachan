//
//  SwiftJSON.swift
//  Ikachan
//
//  Created by Sketch on 2022/9/24.
//

import SwiftyJSON

extension JSON {
    var isNull: Bool {
        if let _ = self.null {
            return true
        }
        
        return false
    }
}
