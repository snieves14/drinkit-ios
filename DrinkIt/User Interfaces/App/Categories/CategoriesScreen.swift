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
            TabHeaderView(headerType: .categories)
        }
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true)
    }
}
