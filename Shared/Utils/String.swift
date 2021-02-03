//
//  String.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/3.
//

import Foundation
import SwiftUI

extension String {
    var localizedString: String {
        let languageCode = Locale.current.languageCode ?? "en"
        
        guard let path = Bundle.main.path(forResource: convertLanguageCode(languageCode: languageCode), ofType: "lproj") else {
            return self
        }
        let bundle = Bundle(path: path)
        
        return bundle?.localizedString(forKey: self, value: nil, table: nil) ?? self
    }
}

/// HACK: Converts language code to localized strings file.
private func convertLanguageCode(languageCode: String) -> String {
    switch languageCode {
    case "zh":
        return "zh-Hans"
    default:
        return languageCode
    }
}
