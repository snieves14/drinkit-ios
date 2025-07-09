//
//  CocktaildbState.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

@MainActor
@Observable
final class CocktaildbState {
    
    // MARK: - Networking Properties
    var requestStatus: RequestStatus = .unknown
    private var lastRefreshDate: Date?
    
    // MARK: - Data Properties
    var drinkResponse: DrinkResponse?
    var cocktails: [Cocktail] = []
    
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
}
