//
//  HomeState.swift
//  DrinkIt
//
//  Created by Santi Nieves on 8/7/25.
//

import SwiftUI
import Alamofire

@MainActor
@Observable
final class HomeState {
    
    // MARK: - Networking Properties
    var requestStatus: RequestStatus = .unknown
    private var lastRefreshDate: Date?
    private var apiGroup: DispatchGroup = DispatchGroup()
    
    // MARK: - Data Properties
    var randomCocktails: [Cocktail] = []
    var firstLetterCocktails: [Cocktail] = []
    var ingredientCocktails: [Cocktail] = []
    var firstLetterCharacter: Character = " "
    var randomIngredient: String = ""
    
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
    
    private func initializeDataProperties(randomIngredient: String?) {
        requestStatus = .unknown
        randomCocktails = []
        firstLetterCocktails = []
        ingredientCocktails = []
        self.firstLetterCharacter = Character.randomLowercaseLetter
        self.randomIngredient = randomIngredient ?? Utils.Defaults.ingredient
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
    func loadHome(refreshPolicy: RefreshPolicy = .ifNeeded, randomIngredient: String?) async {
        if shouldRefreshData(refreshPolicy: refreshPolicy) {
            initializeDataProperties(randomIngredient: randomIngredient)
            LoaderManager.shared.startRequest()
            
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
            "f" : firstLetterCharacter
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
        let parameters: Parameters = [
            "i": randomIngredient
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
