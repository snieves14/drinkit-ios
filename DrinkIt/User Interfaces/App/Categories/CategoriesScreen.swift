//
//  CategoriesScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

struct CategoriesScreen: View {
    var body: some View {
        VStack {
            TabHeaderView(tabHeader: .categories)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true)
    }
}
