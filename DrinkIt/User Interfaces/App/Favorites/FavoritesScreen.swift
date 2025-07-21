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
    @Query(sort: \FavoriteCocktail.strDrink) private var favoriteCocktails: [FavoriteCocktail]
    
    // MARK: - Body
    var body: some View {
        VStack {
            TabHeaderView(headerType: .favorites)
            if !favoriteCocktails.isEmpty {
                ScrollView {
                    VStack(alignment: .leading, spacing: AppStyle.ScrollSpacing.small) {
                        ForEach(favoriteCocktails, id: \.idDrink) { favoriteCocktail in
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
