//
//  FavoritesScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

struct FavoritesScreen: View {
    
    // MARK: - Properties
    @Environment(FavoriteCocktailState.self) var favoriteCocktailState
    
    // MARK: - Body
    var body: some View {
        VStack {
            TabHeaderView(headerType: .favorites)
            if !favoriteCocktailState.cocktails.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: AppStyle.ScrollSpacing.small) {
                        ForEach(favoriteCocktailState.cocktails, id: \.idDrink) { favoriteCocktail in
                            CocktailRowView(cocktail: favoriteCocktail.asCocktail)
                        }
                    }
                    .padding(.bottom, AppStyle.VerticalPadding.regular)
                }
                .scrollViewStyle()
            } else {
                SecondaryBlankDataView(title: "blankData.title.favorites")
            }
        }
        .padding(.bottom, -6) ///ScrollView flush with the TabBar
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true)
    }
}
