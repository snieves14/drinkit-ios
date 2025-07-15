//
//  CocktailDetailScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 11/7/25.
//

import SwiftUI

struct CocktailDetailScreen: View {
    
    // MARK: - Properties
    let cocktail: Cocktail
    
    // MARK: - Body
    var body: some View {
        VStack {
        }
        .baseViewStyle(tabBar: .hidden, toolBarTitle: cocktail.strDrink ?? "cocktailDetail.title")
    }
}
