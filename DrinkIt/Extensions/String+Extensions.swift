//
//  String+Extensions.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import Foundation

extension String {
    var isNotBlank: Bool {
        !trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var firstParagraph: String {
           let separators = ["\r\n\r\n", "\n\n"]
           for separator in separators {
               if let paragraph = self.components(separatedBy: separator).first {
                   return paragraph.trimmingCharacters(in: .whitespacesAndNewlines)
               }
           }
           return self.components(separatedBy: .newlines).first?.trimmingCharacters(in: .whitespacesAndNewlines) ?? self
       }
    
    func localized(comment: String = "") -> String {
        let languageCode = Locale.preferredLanguages.first ?? "en"
        
        if let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: bundlePath) {
            return bundle.localizedString(forKey: self, value: nil, table: nil)
        }
        
        return NSLocalizedString(self, comment: comment)
    }
    
    func localizedWithArguments(comment: String = "", arguments: CVarArg...) -> String {
        let languageCode = Locale.preferredLanguages.first ?? "en"
        
        if let bundlePath = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: bundlePath) {
            return String(format: bundle.localizedString(forKey: self, value: nil, table: nil), arguments)
        }
        
        return String(format: NSLocalizedString(self, bundle: .main, comment: comment), arguments)
    }
    
    func withDrinkThumbnailSize(_ size: Utils.DrinkThumbnailSize) -> String {
        self + size.rawValue
    }
}
