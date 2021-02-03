//
//  String.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/3.
//

import Foundation
import SwiftUI
import Intents

extension String {
    var localizedStringForSiri: String {
        let languageCode = INPreferences.siriLanguageCode()
        
        guard let path = Bundle.main.path(forResource: escapeLanguageCode(languageCode: languageCode), ofType: "lproj") else {
            return self
        }
        let bundle = Bundle(path: path)
        
        return bundle?.localizedString(forKey: self, value: nil, table: nil) ?? self
    }
}

/// HACK: Escapes language code to supported language.
private func escapeLanguageCode(languageCode: String) -> String {
    if languageCode.starts(with: "en") {
        return "en"
    } else if languageCode.starts(with: "ja") {
        return "ja"
    } else if languageCode.starts(with: "zh-Hans") {
        return "zh-Hans"
    } else {
        return "en"
    }
}
