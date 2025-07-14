//
//  MyCocktailsScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

struct MyCocktailsScreen: View {
    var body: some View {
        VStack {
            TabHeaderView(headerType: .myCocktails)
        }
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true)
    }
}
