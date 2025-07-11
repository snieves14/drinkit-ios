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
    var cocktails: [Cocktail]
    
    // MARK: - Body
    var body: some View {
        VStack {
            HomeSectionHeaderView(headerType: .firstLetter(firstLetter), itemCount: cocktails.count, onAction: {
                print("Tap en ver todos - FirstLetterCocktailsView")
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
