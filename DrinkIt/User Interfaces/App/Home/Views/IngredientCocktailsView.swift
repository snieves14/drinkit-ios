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
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                Text("ingredientCocktails.title \(ingredientName)")
                    .textStyle(font: .medium, alignment: .leading, lineLimit: 2)
                Spacer()
                Button("common.see_all") {
                    print("Tap en ver todos - IngredientCocktailsView")
                }.buttonStyle(pillButtonStyle())
            }
            .padding(.horizontal, AppStyle.HorizontalPadding.regular)
        }
    }
}
