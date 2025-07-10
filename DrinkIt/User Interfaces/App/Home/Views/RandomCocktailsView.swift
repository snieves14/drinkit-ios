//
//  RandomCocktailsView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 9/7/25.
//

import SwiftUI

struct RandomCocktailsView: View {
    
    // MARK: - Properties
    var randomCocktails: [Cocktail]
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text("randomCocktails.title")
                .textStyle(font: .medium, alignment: .leading, lineLimit: 2)
                .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            ScrollView(.horizontal) {
                HStack(spacing: AppStyle.ScrollSpacing.regular) {
                    ForEach(randomCocktails, id:\.idDrink) { cocktail in
                        RandomCocktailCardView(cocktail: cocktail)
                    }
                }
                .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            }.scrollViewStyle()
        }
    }
}
