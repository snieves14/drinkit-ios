//
//  FavoriteCocktail.swift
//  DrinkIt
//
//  Created by Santi Nieves on 18/7/25.
//

import SwiftData

@Model
class FavoriteCocktail {
    @Attribute(.unique) var idDrink: String
    var strDrink: String?
    var strDrinkThumb: String?

    init(idDrink: String, strDrink: String? = nil, strDrinkThumb: String? = nil) {
        self.idDrink = idDrink
        self.strDrink = strDrink
        self.strDrinkThumb = strDrinkThumb
    }
    var asCocktail: Cocktail {
        Cocktail(idDrink: idDrink, strDrink: strDrink, strDrinkThumb: strDrinkThumb, strTags: nil, strVideo: nil, strCategory: nil, strIBA: nil, strAlcoholic: nil, strGlass: nil, strInstructions: nil, strInstructionsES: nil, strIngredient1: nil, strIngredient2: nil, strIngredient3: nil, strIngredient4: nil, strIngredient5: nil, strIngredient6: nil, strIngredient7: nil, strIngredient8: nil, strIngredient9: nil, strIngredient10: nil, strIngredient11: nil, strIngredient12: nil, strIngredient13: nil, strIngredient14: nil, strIngredient15: nil, strMeasure1: nil, strMeasure2: nil, strMeasure3: nil, strMeasure4: nil, strMeasure5: nil, strMeasure6: nil, strMeasure7: nil, strMeasure8: nil,   strMeasure9: nil, strMeasure10: nil, strMeasure11: nil, strMeasure12: nil, strMeasure13: nil, strMeasure14: nil, strMeasure15: nil)
    }
}
