//
//  FavoriteButtonView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 18/7/25.
//

import SwiftUI

struct FavoriteButtonView: View {
    
    // MARK: - Properties
    let cocktail: Cocktail
    var primaryColor: Color = .accent
    var size: CGFloat = 18
    
    @Environment(FavoriteCocktailState.self) var favoriteCocktailState
    
    // MARK: - Body
    var body: some View {
        Button("") {
            favoriteCocktailState.toggleFavorite(for: cocktail)
        }
        .buttonStyle(favButtonStyle(isFavorite: favoriteCocktailState.isFavorite(for: cocktail), primaryColor: primaryColor, size: size))
    }
}
