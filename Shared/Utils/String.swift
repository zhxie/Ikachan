//
//  String.swift
//  Ikachan
//
//  Created by Sketch on 2021/2/3.
//

import Intents

extension String {
    var localizedString: String {
        NSLocalizedString(self, comment: "")
    }
    
    var localizedIntentsString: String {
        let languageCode = INPreferences.siriLanguageCode()
        
        guard let path = Bundle.main.path(forResource: escapeLanguageCode(languageCode: languageCode), ofType: "lproj") else {
            return self
        }
        let bundle = Bundle(path: path)
        
        return bundle?.localizedString(forKey: self, value: nil, table: nil) ?? self
    }
}

extension Array where Element == String {
    func concate(delimiter: String) -> String {
        var result = ""
        
        for s in self {
            if !result.isEmpty {
                result = result + delimiter
            }
            
            result = result + s
        }
        
        return result
    }
}

/// HACK: Escapes language code to supported language.
private func escapeLanguageCode(languageCode: String) -> String {
    if languageCode.starts(with: "en") {
        return "en"
    } else if languageCode.starts(with: "ja") {
        return "ja"
    } else if languageCode.starts(with: "zh") {
        return "zh-Hans"
    } else {
        return "en"
    }
}
