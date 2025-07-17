//
//  CocktailDetailIngredientsView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 17/7/25.
//

import SwiftUI

struct CocktailDetailIngredientsView: View {
    
    // MARK: - Properties
    let cocktail: Cocktail?
    
    // MARK: - Body
    var body: some View {
        if let ingredients = cocktail?.ingredients, !ingredients.isEmpty {
            VStack(spacing: AppStyle.StackSpacing.small) {
                Text("cocktailDetail.ingredients")
                    .textStyle(font: .medium, size: AppStyle.TextSize.large, alignment: .leading)
                ForEach(ingredients, id: \.name) { ingredient in
                    Text("\(ingredient.name)\(ingredient.measure.map { " - \($0)" } ?? "")")
                        .textStyle(font: .regular, alignment: .leading)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: AppStyle.CornerRadius.regular)
                    .fill(.surfaceDim)
            )
        }
    }
}
