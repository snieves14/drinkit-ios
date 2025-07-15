//
//  CocktailsScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 11/7/25.
//

import SwiftUI

struct CocktailsScreen: View {
    
    // MARK: - Properties
    let cocktailSectionType: CocktailSectionType
    let cocktails: [Cocktail]
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State private var cocktaildbState = CocktaildbState()
    
    // MARK: - Body
    var body: some View {
        VStack {
            switch cocktaildbState.requestStatus {
            case .success:
                ScrollView {
                    VStack(spacing: AppStyle.StackSpacing.large) {
                        if let ingredient = cocktailSectionType.ingredientName, !cocktaildbState.ingredientDescription.isEmpty {
                            IngredientCardView(title: ingredient, description: cocktaildbState.ingredientDescription.firstParagraph)
                        }
                        VStack(alignment: .leading, spacing: AppStyle.ScrollSpacing.small) {
                            ForEach(cocktails, id: \.idDrink) { cocktail in
                                if cocktailSectionType.ingredientName != nil {
                                    CocktailRowView(cocktail: cocktail)
                                } else {
                                    CocktailCardView(cocktail: cocktail)
                                }
                            }
                        }
                        .padding(.bottom, AppStyle.VerticalPadding.extraLarge)
                    }
                }
                .scrollViewStyle()
                .withTransition()
            default:
                EmptyView()
            }
        }
        .baseViewStyle(tabBar: .hidden, toolBarTitle: cocktailSectionType.title)
        .padding(.bottom, safeAreaInsets.bottom != 0 ? 0 : -8) ///ScrollView flush with the bottom screen
        .edgesIgnoringSafeArea(.bottom) ///Allows scrolling under the home indicator
        .onAppear {
            searchByIngredient()
        }
    }
    
    // MARK: - Private functions
    private func searchByIngredient() {
        guard let ingredient = cocktailSectionType.ingredientName else {
            cocktaildbState.requestStatus = .success
            return
        }
        Task {
            await cocktaildbState.searchByIngredient(ingredient: ingredient)
        }
    }
}
