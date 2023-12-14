import Intents

extension String {
    var localizedString: String {
        NSLocalizedString(self, comment: "")
    }
    
    var localizedIntentsString: String {
        let languageCode = INPreferences.siriLanguageCode()
        
        guard let path = Bundle.main.path(forResource: translateLanguageCode(languageCode: languageCode), ofType: "lproj") else {
            return self
        }
        let bundle = Bundle(path: path)
        
        return bundle?.localizedString(forKey: self, value: nil, table: nil) ?? self
    }
}

private func translateLanguageCode(languageCode: String) -> String {
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
