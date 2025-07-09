//
//  CocktaildbListsState.swift
//  DrinkIt
//
//  Created by Santi Nieves on 9/7/25.
//

import SwiftUI
import Alamofire

@MainActor
@Observable
final class CocktaildbListsState {
    
    // MARK: - Data Properties
    var ingredientsList: [Cocktail] = []
    
    
    // MARK: - Public functions
    func randomIngredientName() -> String? {
        ingredientsList.randomElement()?.strIngredient1
    }
    
    // MARK: - Ingredients list request
    func listOfIngredients() async {
        guard ingredientsList.isEmpty else { return }
        let parameters: Parameters = [
            "i" :"list"
        ]
        LoaderManager.shared.startRequest()
        if let response = await CocktaildbWebServices.list(parameters: parameters) {
            await MainActor.run {
                if let data = response.drinks, !data.isEmpty {
                    ingredientsList = data
                }
            }
        }
        LoaderManager.shared.endRequest()
    }
}
