//
//  DrinkResponseTests.swift
//  DrinkIt
//
//  Created by Santi Nieves on 24/7/25.
//

import Testing
@testable import DrinkIt

@Suite("DrinkResponse")
struct DrinkResponseTests {
    
    @Test("ingredients filters out nil or blank ingredient names")
    func testIngredientsFiltersCorrectly() {
        let cocktail = Cocktail(
            idDrink: "123",
            strDrink: "Test",
            strDrinkThumb: nil,
            strTags: nil,
            strVideo: nil,
            strCategory: nil,
            strIBA: nil,
            strAlcoholic: nil,
            strGlass: nil,
            strInstructions: nil,
            strInstructionsES: nil,
            strIngredient1: "Gin",
            strIngredient2: "Tonic",
            strIngredient3: "Vodka",
            strIngredient4: nil,
            strIngredient5: "Brandy",
            strIngredient6: "   ",
            strIngredient7: nil,
            strIngredient8: nil,
            strIngredient9: nil, strIngredient10: nil, strIngredient11: nil,
            strIngredient12: nil, strIngredient13: nil, strIngredient14: nil,
            strIngredient15: nil, strMeasure1: "50ml", strMeasure2: "20ml",
            strMeasure3: "30ml", strMeasure4: "90ml",
            strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil,
            strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil,
            strMeasure13: nil, strMeasure14: nil, strMeasure15: nil
        )

        let ingredients = cocktail.ingredients

        #expect(ingredients.count == 4)
        #expect(ingredients[0].name == "Gin")
        #expect(ingredients[0].measure == "50ml")
        #expect(ingredients[1].name == "Tonic")
        #expect(ingredients[1].measure == "20ml")
        #expect(ingredients[2].name == "Vodka")
        #expect(ingredients[2].measure == "30ml")
        #expect(ingredients[3].name == "Brandy")
        #expect(ingredients[3].measure == nil)
    }
}
