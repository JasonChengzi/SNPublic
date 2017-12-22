//
//  SNLocalization.swift
//  VTravel
//
//  Created by Jason Lee on 26/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import Foundation

extension SN { 
    class Localization {
        static let `default` = SN.Localization()
        
        fileprivate var _language: Language = .eng
        
        fileprivate init() { reload() }
    }
}
extension SN.Localization {
    var current: Language { 
        get { return _language }
        set { _language = newValue }
    }
    func setup() {
        reload()
    }
}
fileprivate extension SN.Localization {
    func reload() {
        var content: String? 
        if let result = loadLocalizationFromUserDefault() { content = result } 
        else {
            content = loadLocalizationFromLocalizedFile()
            setAppLocale(keyValue: content ?? Language.eng.rawValue)
        }
        _language = Language(key: content)
    }
}
fileprivate extension SN.Localization {
    func setAppLocale(keyValue: String) {
        UserDefaults.standard.set(keyValue, forKey: Config.Key.APPLICATION_LANGUAGE)
        UserDefaults.standard.synchronize()
    }
    func loadLocalizationFromUserDefault() -> String? { return UserDefaults.standard.string(forKey: Config.Key.APPLICATION_LANGUAGE) }
    func loadLocalizationFromLocalizedFile() -> String? {
        guard let path = Bundle.main.path(forResource: String(describing: self), ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) as? StandardDictionary else { return nil }
        return dictionary.string(for: Config.Key.APPLICATION_LANGUAGE_FILE_KEY)
    }
}
fileprivate extension SN.Localization {
    func getLocalized(base: String, _ parameters: [Language : String?]) -> String {
        guard _language != .eng else { return base }
        var tempString = base
        for parameter in parameters {
            if let string = parameter.value, parameter.key == _language {
                tempString = string
                break
            }
        }
        return tempString
    }
}
extension SN.Localization {
    enum Language: String {
        case eng, zh_cn, zh_tw
        
        init(key: String?) {
            self = .eng
            if let key = key {
                if key == "zh-Hans" { self = .zh_cn } 
                else if key == "zh-Hant" { self = .zh_tw }
            }
        }
    }
}
extension SN.Localization { struct Config {} }
extension SN.Localization.Config { struct Key {} }
extension SN.Localization.Config.Key {
    static let APPLICATION_LANGUAGE_FILE_KEY = "LocalizationKey"
    static let APPLICATION_LANGUAGE = "application_language"
}

extension String {
    static func localized(base: String, zh_cn: String? = nil, zh_tw: String? = nil) -> String {
        return SN.Localization.default.getLocalized(base: base, [.zh_cn : zh_cn, .zh_tw: zh_tw])
    }
    static func localized(_ base: String, _ zh_cn: String? = nil, _ zh_tw: String? = nil) -> String {
        return localized(base: base, zh_cn: zh_cn, zh_tw: zh_tw)
    }
    static func localized(默认: String, 简体: String? = nil, 繁体: String? = nil) -> String {
        return localized(base: 默认, zh_cn: 简体, zh_tw: 繁体)
    }
}
