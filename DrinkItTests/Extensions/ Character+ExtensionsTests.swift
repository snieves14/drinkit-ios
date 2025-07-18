//
//   Character+ExtensionsTests.swift
//  DrinkIt
//
//  Created by Santi Nieves on 18/7/25.
//

import Testing
@testable import DrinkIt

@Suite("Character+Extensions")
struct Character_ExtensionsTests {

    @Test("randomLowercaseLetter returns a valid alphabet character")
    func testRandomLowercaseLetterIsInAlphabetRange() async throws {
        let validLetters = "abcdefghijklmnopqrstuvwxyz"
        let letter = Character.randomLowercaseLetter

        #expect(validLetters.contains(letter))
        
    }
}
