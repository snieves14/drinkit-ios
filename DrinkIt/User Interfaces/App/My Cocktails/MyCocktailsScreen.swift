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
        .frame(maxHeight: .infinity, alignment: .top)
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true)
    }
}
