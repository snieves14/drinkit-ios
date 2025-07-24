//
//  CocktailsSearchScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

struct CocktailsSearchScreen: View {
    
    // MARK: - Properties
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    // MARK: - Body
    var body: some View {
        VStack {
            TabHeaderView(headerType: .cocktailsSearch)
        }
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true, bottomPadding: safeAreaInsets.bottom == 0 ? AppStyle.VerticalPadding.xxxLarge : AppStyle.VerticalPadding.large)
    }
}
