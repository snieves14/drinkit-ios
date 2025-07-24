//
//  FavoriteCocktailTests.swift
//  DrinkIt
//
//  Created by Santi Nieves on 24/7/25.
//

import Testing
@testable import DrinkIt

@Suite("FavoriteCocktail")
struct FavoriteCocktailTests {
    
    @Test("asCocktail creates a Cocktail with matching fields")
    func testAsCocktailCreatesValidCocktail() {
        let favorite = FavoriteCocktail(
            idDrink: "12345",
            strDrink: "Margarita",
            strDrinkThumb: "https://image.url"
        )
        
        let cocktail = favorite.asCocktail
        
        #expect(cocktail.idDrink == "12345")
        #expect(cocktail.strDrink == "Margarita")
        #expect(cocktail.strDrinkThumb == "https://image.url")
        #expect(cocktail.strGlass == nil)
    }

}
