//
//  FavoritesScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI
import SwiftData

struct FavoritesScreen: View {
    
    // MARK: - Properties
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    @Query(sort: \FavoriteCocktail.strDrink) private var favoriteCocktails: [FavoriteCocktail]
    
    // MARK: - Body
    var body: some View {
        VStack {
            TabHeaderView(headerType: .favorites)
            if !favoriteCocktails.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: AppStyle.ScrollSpacing.small) {
                        ForEach(favoriteCocktails, id: \.idDrink) { favoriteCocktail in
                            CocktailRowView(cocktail: favoriteCocktail.asCocktail, shouldShowFavoriteButton: false)
                        }
                    }
                    .padding(.bottom, AppStyle.VerticalPadding.regular)
                }
                .scrollViewStyle()
            } else {
                SecondaryBlankDataView(title: "blankData.title.favorites")
            }
        }
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true, bottomPadding: safeAreaInsets.bottom == 0 ? AppStyle.VerticalPadding.xxxLarge : AppStyle.VerticalPadding.large)
    }
}
