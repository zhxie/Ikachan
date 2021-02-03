//
//  LocalizedStringKey.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/3.
//

import Foundation
import SwiftUI

extension LocalizedStringKey {
    var rawValue: String {
        let description = "\(self)"

        let components = description.components(separatedBy: "key: \"")
            .map { $0.components(separatedBy: "\",") }

        return components[1][0]
    }
    
    var localizedString: String {
        self.rawValue.localizedString
    }
}
