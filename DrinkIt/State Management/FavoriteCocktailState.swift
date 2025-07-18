//
//  FavoriteCocktailState.swift
//  DrinkIt
//
//  Created by Santi Nieves on 18/7/25.
//

import SwiftData

@MainActor
@Observable
final class FavoriteCocktailState {
    
    // MARK: - Properties
    private let modelContext: ModelContext
    var cocktails: [FavoriteCocktail] = []
    
    // MARK: - Init
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.cocktails = try! modelContext.fetch(FetchDescriptor<FavoriteCocktail>()).sorted { ($0.strDrink ?? "") < ($1.strDrink ?? "") }
    }
    
    // MARK: - Functions
    func isFavorite(for cocktail: Cocktail) -> Bool {
        guard let idDrink = cocktail.idDrink else { return false }
        
        return cocktails.contains { $0.idDrink == idDrink }
    }
    
    func toggleFavorite(for cocktail: Cocktail) {
        isFavorite(for: cocktail) ? removeFromFavorites(for: cocktail) : addToFavorites(for: cocktail)
    }

    private func addToFavorites(for cocktail: Cocktail) {
        guard let idDrink = cocktail.idDrink, !isFavorite(for: cocktail) else { return }
        
        let favoriteCocktail = FavoriteCocktail(idDrink: idDrink, strDrink: cocktail.strDrink, strDrinkThumb: cocktail.strDrinkThumb)
        modelContext.insert(favoriteCocktail)
        saveModelContext()
    }

    private func removeFromFavorites(for cocktail: Cocktail) {
        guard let idDrink = cocktail.idDrink else { return }
        
        if let favoriteCocktail = cocktails.first(where: { $0.idDrink == idDrink }) {
            modelContext.delete(favoriteCocktail)
            saveModelContext()
        }
    }
    
    private func saveModelContext() {
        try? modelContext.save()
        cocktails = try! modelContext.fetch(FetchDescriptor<FavoriteCocktail>()).sorted { ($0.strDrink ?? "") < ($1.strDrink ?? "") }
    }
}
