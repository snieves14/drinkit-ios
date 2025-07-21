//
//  FavoriteButtonView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 18/7/25.
//

import SwiftUI
import SwiftData

struct FavoriteButtonView: View {
    
    // MARK: - Properties
    let cocktail: Cocktail
    var primaryColor: Color = .accent
    var size: CGFloat = 18
    
    @Environment(\.modelContext) private var context
    @Query private var favoriteCocktails: [FavoriteCocktail]
    
    private var isFavorite: Bool {
        favoriteCocktails.contains(where: { $0.idDrink == cocktail.idDrink })
    }
    
    // MARK: - Body
    var body: some View {
        Button("") {
            toggleFavorite()
        }
        .buttonStyle(favButtonStyle(isFavorite: isFavorite, primaryColor: primaryColor, size: size))
    }

   
    // MARK: - Private functions
    private func toggleFavorite() {
        guard let idDrink = cocktail.idDrink else { return }
        if let existing = favoriteCocktails.first(where: { $0.idDrink == idDrink }) {
            context.delete(existing)
        } else {
            let newFavorite = FavoriteCocktail(idDrink: idDrink, strDrink: cocktail.strDrink, strDrinkThumb: cocktail.strDrinkThumb)
            context.insert(newFavorite)
        }
        try? context.save()
    }
}
