//
//  String+Extensions.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import Foundation

extension String {
    func localized(comment: String = "", locale: Locale? = nil) -> String {
        guard let bundlePath = Bundle.main.path(forResource: locale?.identifier, ofType: "lproj"), let bundle = Bundle(path: bundlePath) else {
            return NSLocalizedString(self, comment: comment)
        }
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
    
    func localizedWithArguments(comment: String = "", locale: Locale? = nil, arguments: CVarArg...) -> String {
        guard let bundlePath = Bundle.main.path(forResource: locale?.identifier, ofType: "lproj"), let bundle = Bundle(path: bundlePath) else {
            return String(format: NSLocalizedString(self, bundle: .main, comment: comment), arguments)
        }
        return String(format: bundle.localizedString(forKey: self, value: nil, table: nil), arguments)
    }
}
