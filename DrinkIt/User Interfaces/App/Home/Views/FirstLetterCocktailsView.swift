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
    var ingredientCocktails: [Cocktail]
    
    // MARK: - Body
    var body: some View {
        VStack {
            HStack {
                Text("firstLetterCocktails.title \(String(firstLetter).uppercased())")
                    .textStyle(font: .medium, alignment: .leading, lineLimit: 2)
                Spacer()
                Button("common.see_all") {
                    print("Tap en ver todos - FirstLetterCocktailsView")
                }.buttonStyle(pillButtonStyle())
            }
        }
    }
}
