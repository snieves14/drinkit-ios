//
//  CocktailDetailScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 11/7/25.
//

import SwiftUI

struct CocktailDetailScreen: View {
    var body: some View {
        VStack {
            Text("Top")
            Spacer()
            Text("Cocktail Detail Screen")
            Spacer()
            Text("Bottom")
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .baseViewStyle(tabBar: .hidden, toolBarTitle: "Title")
    }
}
