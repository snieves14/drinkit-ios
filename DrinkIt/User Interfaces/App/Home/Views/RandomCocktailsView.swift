//
//  RandomCocktailsView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 9/7/25.
//

import SwiftUI

struct RandomCocktailsView: View {
    
    // MARK: - Properties
    let cocktails: [Cocktail]
    
    @Environment(AppState.self) var appState
    
    // MARK: - Body
    var body: some View {
        VStack {
            HomeSectionHeaderView(cocktailSectionType: .random, itemCount: cocktails.count, onAction: {
                appState.pushTo(.cocktailsManagement(.cocktailsScreen(cocktailSectionType: CocktailSectionType.random, cocktails: cocktails)))
            })
            .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            ScrollView(.horizontal) {
                HStack(spacing: AppStyle.ScrollSpacing.small) {
                    ForEach(cocktails, id:\.idDrink) { cocktail in
                        RandomCocktailCardView(cocktail: cocktail)
                    }
                }
                .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            }.scrollViewStyle()
        }
    }
}
