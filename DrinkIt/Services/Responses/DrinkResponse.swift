//
//  DrinkResponse.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

struct DrinkResponse: Response, Codable {
    var errors: [ErrorResponse]?
    let drinks: [Cocktail]?
}

struct CocktailIngredient {
    let name: String
    let measure: String?
}

struct Cocktail: Codable {
    let idDrink: String?
    let strDrink: String?
    let strDrinkThumb: String?
    let strTags: String?
    let strVideo: String?
    let strCategory: String?
    let strIBA: String?
    let strAlcoholic: String?
    let strGlass: String?
    let strInstructions: String?
    let strInstructionsES: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    
    var ingredients: [CocktailIngredient] {
        [(strIngredient1, strMeasure1), (strIngredient2, strMeasure2), (strIngredient3, strMeasure3), (strIngredient4, strMeasure4), (strIngredient5, strMeasure5), (strIngredient6, strMeasure6), (strIngredient7, strMeasure7), (strIngredient8, strMeasure8), (strIngredient9, strMeasure9), (strIngredient10, strMeasure10), (strIngredient11, strMeasure11), (strIngredient12, strMeasure12), (strIngredient13, strMeasure13), (strIngredient14, strMeasure14), (strIngredient15, strMeasure15)]
            .compactMap { (ingredient, measure) in
                guard let name = ingredient, name.isNotBlank else { return nil }
            return CocktailIngredient(name: name, measure: measure)
        }
    }
    
    var ingredientNames: String {
        ingredients.map(\.name).joined(separator: ", ")
    }

    var localizedInstructions: String? {
        let languageCode = Locale.preferredLanguages.first ?? "en"
        if languageCode.hasPrefix("es"),
           let es = strInstructionsES, es.isNotBlank {
            return es
        } else if let en = strInstructions, en.isNotBlank {
            return en
        }
        return nil
    }
}
