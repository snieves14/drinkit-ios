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
    
    // MARK: - Networking Properties
    var ingredientsRequestStatus: RequestStatus = .unknown
    var alcoholicRequestStatus: RequestStatus = .unknown
    var categoriesRequestStatus: RequestStatus = .unknown
    var glassesRequestStatus: RequestStatus = .unknown
    
    // MARK: - Data Properties
    var ingredientsList: [Cocktail] = []
    var alcoholicList: [Cocktail] = []
    var categoriesList: [Cocktail] = []
    var glassesList: [Cocktail] = []
    
    
    // MARK: - Public functions
    func randomIngredientName() -> String? {
        ingredientsList.randomElement()?.strIngredient1
    }
    
    // MARK: - Ingredients list request
    func listOfIngredients() async {
        guard ingredientsList.isEmpty && ingredientsRequestStatus != .empty else { return }
        let parameters: Parameters = [
            "i" :"list"
        ]
        LoaderManager.shared.startRequest()
        if let response = await CocktaildbWebServices.list(parameters: parameters) {
            await MainActor.run {
                if let data = response.drinks {
                    ingredientsList = data.sorted { ($0.strIngredient1 ?? "").localizedCaseInsensitiveCompare($1.strIngredient1 ?? "") == .orderedAscending }
                    ingredientsRequestStatus =  data.isEmpty ? .empty : .success
                } else {
                    ingredientsRequestStatus = .failure
                }
            }
        }
        LoaderManager.shared.endRequest()
    }
    
    // MARK: - Alcoholic list request
    func listOfAlcoholic() async {
        guard alcoholicList.isEmpty && alcoholicRequestStatus != .empty else { return }
        let parameters: Parameters = [
            "a" :"list"
        ]
        LoaderManager.shared.startRequest()
        if let response = await CocktaildbWebServices.list(parameters: parameters) {
            await MainActor.run {
                if let data = response.drinks {
                    alcoholicList = data.sorted { ($0.strAlcoholic ?? "").localizedCaseInsensitiveCompare($1.strAlcoholic ?? "") == .orderedAscending }
                    alcoholicRequestStatus =  data.isEmpty ? .empty : .success
                } else {
                    alcoholicRequestStatus = .failure
                }
            }
        }
        LoaderManager.shared.endRequest()
    }
    
    // MARK: - Categories list request
    func listOfCategories() async {
        guard categoriesList.isEmpty && categoriesRequestStatus != .empty else { return }
        let parameters: Parameters = [
            "c" :"list"
        ]
        LoaderManager.shared.startRequest()
        if let response = await CocktaildbWebServices.list(parameters: parameters) {
            await MainActor.run {
                if let data = response.drinks {
                    categoriesList = data.sorted { ($0.strCategory ?? "").localizedCaseInsensitiveCompare($1.strCategory ?? "") == .orderedAscending }
                    categoriesRequestStatus =  data.isEmpty ? .empty : .success
                } else {
                    categoriesRequestStatus = .failure
                }
            }
        }
        LoaderManager.shared.endRequest()
    }
    
    // MARK: - Glasses list request
    func listOfGlasses() async {
        guard glassesList.isEmpty && glassesRequestStatus != .empty else { return }
        let parameters: Parameters = [
            "g" :"list"
        ]
        LoaderManager.shared.startRequest()
        if let response = await CocktaildbWebServices.list(parameters: parameters) {
            await MainActor.run {
                if let data = response.drinks {
                    glassesList = data.sorted { ($0.strGlass ?? "").localizedCaseInsensitiveCompare($1.strGlass ?? "") == .orderedAscending }
                    glassesRequestStatus =  data.isEmpty ? .empty : .success
                } else {
                    glassesRequestStatus = .failure
                }
            }
        }
        LoaderManager.shared.endRequest()
    }
}
