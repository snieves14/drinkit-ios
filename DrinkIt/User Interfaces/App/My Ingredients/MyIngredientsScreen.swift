//
//  MyIngredientsScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

struct MyIngredientsScreen: View {
    var body: some View {
        VStack {
            TabHeaderView(tabHeader: .myIngredients)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true)
    }
}
