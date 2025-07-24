//
//  CocktaildbState.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI
import Combine
import Alamofire

@MainActor
@Observable
final class CocktaildbState {
    
    // MARK: - Networking Properties
    var requestStatus: RequestStatus = .unknown
    private var lastRefreshDate: Date?
    
    // MARK: - Data Properties [lookup request]
    var drinkResponse: DrinkResponse?
    var cocktail: Cocktail?
    
    // MARK: - Data Properties [Search request]
    var ingredientDescription: String = ""
    
    // MARK: - Data Properties [Filter requests]
    var cocktails: [Cocktail] = []
    
    // MARK: - Data Properties [filterByPublisher requests]
    private let searchTextSubject = PassthroughSubject<String, Never>()
    var searchText: String = "" {
        didSet {
            searchTextSubject.send(searchText)
        }
    }
    
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
    
    // MARK: - filterByPublisher functions
    func resetFilterResults() {
        cocktails = []
        requestStatus = .unknown
    }
    
    // MARK: - Lookup cocktail request
    func lookup(refreshPolicy: RefreshPolicy = .ifNeeded, idDrink: String) async {
        let parameters: Parameters = [
            "i" : idDrink
        ]
        if shouldRefreshData(refreshPolicy: refreshPolicy) {
            requestStatus = refreshPolicy == .always ? .unknown : requestStatus
            LoaderManager.shared.startRequest()
            if let response = await CocktaildbWebServices.lookup(parameters: parameters) {
                await MainActor.run {
                    drinkResponse = response
                    if let _ = drinkResponse?.errors {
                        requestStatus = .failure
                    } else {
                        if let data = drinkResponse?.drinks {
                            guard let cocktail = data.first else {
                                requestStatus = .empty
                                return
                            }
                            self.cocktail = cocktail
                            lastRefreshDate = Date()
                            requestStatus = .success
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
    
    // MARK: - Filter by ingredient request
    func filterBy(for categoryType: CategoryType, value: String) async {
        guard cocktails.isEmpty && requestStatus != .empty else { return }
        let parameters: Parameters = [
            categoryType.parameterKey : value
        ]
        LoaderManager.shared.startRequest()
        if let response = await CocktaildbWebServices.filter(parameters: parameters) {
            await MainActor.run {
                if let data = response.drinks {
                    cocktails = data
                    requestStatus =  data.isEmpty ? .empty : .success
                } else {
                    requestStatus = .failure
                }
            }
        }
        LoaderManager.shared.endRequest()
    }
    
    
    func filterByPublisher(for categoryType: CategoryType) -> AnyCancellable {
        searchTextSubject
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .handleEvents(receiveOutput: { [weak self] value in
                if value.count <= 2 {
                    self?.resetFilterResults()
                }
            })
            .filter { $0.count > 2 }
            .map { value -> AnyPublisher<DrinkResponse, Never> in
                let parameters: Parameters = [categoryType.parameterKey: value]
                return CocktaildbWebServices.filterPublisher(parameters: parameters)
            }
            .switchToLatest()
            .sink { [weak self] response in
                guard let self else { return }
                if let data = response.drinks {
                    cocktails = data
                    requestStatus = data.isEmpty ? .empty : .success
                } else {
                    cocktails = []
                    requestStatus = .failure
                }
            }
    }
}
