//
//  IngredientCocktailsView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 9/7/25.
//

import SwiftUI

struct IngredientCocktailsView: View {
    
    // MARK: - Properties
    let ingredientName: String
    var cocktails: [Cocktail]
    
    @Environment(AppState.self) var appState
    
    // MARK: - Body
    var body: some View {
        VStack {
            HomeSectionHeaderView(headerType: .ingredient(ingredientName), itemCount: cocktails.count, onAction: {
                appState.pushTo(.cocktailsManagement(.cocktailsScreen))
            })
            .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            ScrollView {
                VStack(spacing: AppStyle.ScrollSpacing.small) {
                    ForEach(cocktails.prefix(5), id:\.idDrink) { cocktail in
                        IngredientCocktailCardView(cocktail: cocktail)
                    }
                }
                .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            }
            .scrollViewStyle()
        }
    }
}
