//
//  String+ExtensionsTests.swift
//  DrinkIt
//
//  Created by Santi Nieves on 18/7/25.
//

import Testing
@testable import DrinkIt

@Suite("String+Extensions") 
struct String_ExtensionsTests {
    
    @Test("isNotBlank should return true for non-empty strings")
    func testIsNotBlankTrue() {
        #expect("Hello".isNotBlank)
        #expect("  World  ".isNotBlank)
        #expect("\n\tSomething\n".isNotBlank)
    }

    @Test("isNotBlank should return false for blank strings")
    func testIsNotBlankFalse() {
        #expect("".isNotBlank == false)
        #expect("     ".isNotBlank == false)
        #expect("\n\t  \n".isNotBlank == false)
    }

    @Test("firstParagraph should return text up to first paragraph break")
    func testFirstParagraph() {
        #expect("Vodka is a distilled beverage composed primarily of water and ethanol, sometimes with traces of impurities and flavorings. Traditionally, vodka is made by the distillation of fermented cereal grains or potatoes, though some modern brands use other substances, such as fruits or sugar.\r\n\r\nSince the 1890s, the standard Polish, Russian, Belarusian, Ukrainian, Estonian, Latvian, Lithuanian and Czech vodkas are 40% alcohol by volume ABV (80 US proof), a percentage that is widely misattributed to Dmitri Mendeleev. The European Union has established a minimum of 37.5% ABV for any \"European vodka\" to be named as such".firstParagraph == "Vodka is a distilled beverage composed primarily of water and ethanol, sometimes with traces of impurities and flavorings. Traditionally, vodka is made by the distillation of fermented cereal grains or potatoes, though some modern brands use other substances, such as fruits or sugar.")
        #expect("One\r\n\r\nTwo\r\n\r\nThree".firstParagraph == "One")
        #expect("Only one paragraph".firstParagraph == "Only one paragraph")
    }

    @Test("withDrinkThumbnailSize should append correct suffix")
    func testWithDrinkThumbnailSize() {
        #expect("https://image.com".withDrinkThumbnailSize(.none) == "https://image.com")
        #expect("https://image.com".withDrinkThumbnailSize(.small) == "https://image.com/small")
        #expect("https://image.com".withDrinkThumbnailSize(.medium) == "https://image.com/medium")
        #expect("https://image.com".withDrinkThumbnailSize(.large) == "https://image.com/large")
    }
}
