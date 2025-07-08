//
//  Character+Extensions.swift
//  DrinkIt
//
//  Created by Santi Nieves on 8/7/25.
//

import Foundation

extension Character {
    static var randomLowercaseLetter: Character {
        let letters = "abcdefghijklmnopqrstuvwxyz"
        return letters.randomElement()!
    }
}
