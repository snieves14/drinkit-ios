//
//  HomeState.swift
//  DrinkIt
//
//  Created by Santi Nieves on 8/7/25.
//

import SwiftUI
import Alamofire

@MainActor
class HomeState: ObservableObject {
    
    // MARK: - Networking Properties
    @Published var apiGroup: DispatchGroup = DispatchGroup()
    @Published var requestStatus: RequestStatus = .unknown
    private var lastRefreshDate: Date?
    
    // MARK: - Data Properties
    @Published var randomCocktails: [Cocktail] = []
    @Published var firstLetterCocktails: [Cocktail] = []
    @Published var ingredientsList: [Cocktail] = []
    @Published var ingredientCocktails: [Cocktail] = []
    
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
    
    private func setApiGroup(times: Int) {
        for _ in 0..<times {
            apiGroup.enter()
        }
        
        apiGroup.notify(queue: .main) {
            LoaderManager.shared.endRequest()
            let allCocktailsEmpty = self.randomCocktails.isEmpty && self.firstLetterCocktails.isEmpty && self.ingredientCocktails.isEmpty
            self.requestStatus = allCocktailsEmpty ? .empty : .success
            if !allCocktailsEmpty { self.lastRefreshDate = Date() }
        }
    }
    
    // MARK: - ApiGroup request
    func loadHome(refreshPolicy: RefreshPolicy = .ifNeeded) async {
        if shouldRefreshData(refreshPolicy: refreshPolicy) {
            requestStatus = .unknown
            LoaderManager.shared.startRequest()
            
            await listAllIngredients()
            
            setApiGroup(times: 7)
            await withTaskGroup(of: Void.self) { group in
                for _ in 0..<5 {
                    group.addTask {
                        await self.random()
                    }
                }
                group.addTask {
                    await self.searchByFirstLetter()
                }
                group.addTask {
                    await self.filterByIngredient()
                }
            }
        }
    }
    
    // MARK: - Ingredients list request
    private func listAllIngredients() async {
        let parameters: Parameters = [
            "i" :"list"
        ]
        if let response = await CocktaildbWebServices.list(parameters: parameters) {
            await MainActor.run {
                if let data = response.drinks, !data.isEmpty {
                    ingredientsList = data
                }
            }
        }
    }
    
    // MARK: - Random cocktail request
    private func random() async {
        if let response = await CocktaildbWebServices.random() {
            await MainActor.run {
                if let data = response.drinks, !data.isEmpty {
                    let existingIDs = Set(randomCocktails.map(\.idDrink))
                    let newCocktails = data.filter { !existingIDs.contains($0.idDrink) }
                    randomCocktails.append(contentsOf: newCocktails)
                }
                apiGroup.leave()
            }
        }
    }
    
    // MARK: - Search by first letter request
    private func searchByFirstLetter() async {
        let parameters: Parameters = [
            "f" : Character.randomLowercaseLetter
        ]
        if let response = await CocktaildbWebServices.search(parameters: parameters) {
            await MainActor.run {
                if let data = response.drinks, !data.isEmpty {
                    firstLetterCocktails = data
                }
                apiGroup.leave()
            }
        }
    }
    
    // MARK: - Filter by ingredient request
    private func filterByIngredient() async {
        let ingredient = ingredientsList.randomElement()?.strIngredient1 ?? "Vodka"
        let parameters: Parameters = [
            "i": ingredient
        ]
        if let response = await CocktaildbWebServices.filter(parameters: parameters) {
            await MainActor.run {
                if let data = response.drinks, !data.isEmpty {
                    ingredientCocktails = data
                }
                apiGroup.leave()
            }
        }
    }
}
