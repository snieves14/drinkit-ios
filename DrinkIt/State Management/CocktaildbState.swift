//
//  CocktaildbState.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI
import Alamofire

@MainActor
@Observable
final class CocktaildbState {
    
    // MARK: - Networking Properties
    var requestStatus: RequestStatus = .unknown
    private var lastRefreshDate: Date?
    
    // MARK: - Data Properties [Random request]
    var drinkResponse: DrinkResponse?
    var cocktails: [Cocktail] = []
    
    // MARK: - Data Properties [Search request]
    var ingredientDescription: String = ""
    
    // MARK: - Networking functions
    private func shouldRefreshData(refreshPolicy: RefreshPolicy) -> Bool {
        switch refreshPolicy {
        case .always:
            return true
        case .ifNeeded:
            guard let last = lastRefreshDate else { return true }
            return Date().timeIntervalSince(last) > refreshInterval
        case .never:
            return lastRefreshDate == nil
        }
    }
    
    // MARK: - Random cocktail request
    func random(refreshPolicy: RefreshPolicy = .ifNeeded) async {
        if shouldRefreshData(refreshPolicy: refreshPolicy) {
            requestStatus = .unknown
            LoaderManager.shared.startRequest()
            if let response = await CocktaildbWebServices.random() {
                await MainActor.run {
                    drinkResponse = response
                    if let _ = drinkResponse?.errors {
                        requestStatus = .failure
                    } else {
                        if let data = drinkResponse?.drinks {
                            cocktails = data
                            lastRefreshDate = Date()
                            requestStatus = data.isEmpty ? .empty : .success
                        } else {
                            requestStatus = .failure
                        }
                    }
                }
            }
            LoaderManager.shared.endRequest()
        }
    }
    
    // MARK: - Search by ingredient request
    func searchByIngredient(ingredient: String) async {
        guard ingredientDescription.isEmpty else { return }
        let parameters: Parameters = [
            "i" : ingredient
        ]
        LoaderManager.shared.startRequest()
        if let response = await CocktaildbWebServices.search(parameters: parameters) as IngredientResponse? {
            await MainActor.run {
                if let data = response.ingredients?.first?.strDescription, !data.isEmpty {
                    ingredientDescription = data
                }
                requestStatus = .success
            }
        }
        LoaderManager.shared.endRequest()
    }
}
