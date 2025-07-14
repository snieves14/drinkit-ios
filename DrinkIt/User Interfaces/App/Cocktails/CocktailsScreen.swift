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
    
    // MARK: - Body
    var body: some View {
        VStack {
            ScrollView {
                if let ingredient = cocktailSectionType.ingredientName {
                    Text(ingredient)
                        .textStyle(size: 30)
                }
                VStack(spacing: AppStyle.ScrollSpacing.small) {
                    ForEach(cocktails, id:\.idDrink) { cocktail in
                        if let name = cocktail.strDrink {
                            Text(name)
                        }
                    }
                }
                .padding(.vertical, AppStyle.VerticalPadding.large)
                .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            }
            .scrollViewStyle()
        }
        .baseViewStyle(tabBar: .hidden, toolBarTitle: cocktailSectionType.title)
        .padding(.bottom, safeAreaInsets.bottom != 0 ? 0 : -8) ///ScrollView flush with the bottom screen
        .edgesIgnoringSafeArea(.bottom) ///Allows scrolling under the home indicator
    }
}
