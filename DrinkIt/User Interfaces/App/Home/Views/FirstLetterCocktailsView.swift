//
//  FirstLetterCocktailsView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 9/7/25.
//

import SwiftUI

struct FirstLetterCocktailsView: View {
    
    // MARK: - Properties
    let firstLetter: Character
    let cocktails: [Cocktail]
    
    @Environment(AppState.self) var appState
    
    // MARK: - Body
    var body: some View {
        VStack {
            HomeSectionHeaderView(cocktailSectionType: .firstLetter(firstLetter), itemCount: cocktails.count, onAction: {
                appState.pushTo(.cocktailsManagement(.cocktailsScreen(cocktailSectionType: CocktailSectionType.firstLetter(firstLetter), cocktails: cocktails)))
            })
            .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            ScrollView(.horizontal) {
                HStack(spacing: AppStyle.ScrollSpacing.small) {
                    ForEach(cocktails.prefix(5), id:\.idDrink) { cocktail in
                        FirstLetterCocktailCardView(cocktail: cocktail)
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            }
            .scrollViewStyle()
            .scrollTargetBehavior(.viewAligned)
        }
    }
}
