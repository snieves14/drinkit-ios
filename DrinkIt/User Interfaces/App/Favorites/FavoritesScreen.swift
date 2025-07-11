//
//  FavoritesScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

struct FavoritesScreen: View {
    var body: some View {
        VStack {
            TabHeaderView(headerType: .favorites)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true)
    }
}
