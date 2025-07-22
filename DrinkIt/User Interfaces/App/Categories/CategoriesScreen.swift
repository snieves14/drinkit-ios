//
//  CategoriesScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

// MARK: - Enums
public enum CategoryType: CaseIterable {
    case ingredients
    case alcohol
    case styles
    case glasses
    
    var image: String {
        switch self {
        case .ingredients: return "icon_chef_hat"
        case .alcohol: return "icon_bottle"
        case .styles: return "icon_corkscrew"
        case .glasses: return "icon_glass"
        }
    }
    
    var title: String {
        rawTitle.localized()
    }
    
    private var rawTitle: String {
        switch self {
        case .ingredients: return "categories.ingredients.title"
        case .alcohol: return "categories.alcohol.title"
        case .styles: return "categories.styles.title"
        case .glasses: return "categories.glasses.title"
        }
    }

    var parameterKey: String {
        switch self {
        case .ingredients: return "i"
        case .alcohol:     return "a"
        case .styles:      return "c"
        case .glasses:     return "g"
        }
    }
}

struct CategoriesScreen: View {
    
    // MARK: - Body
    var body: some View {
        VStack {
            TabHeaderView(headerType: .categories)
            Grid(horizontalSpacing: AppStyle.GridSpacing.large, verticalSpacing: AppStyle.GridSpacing.large) {
                let types = CategoryType.allCases
                ForEach(0..<types.count / 2, id: \.self) { rowIndex in
                    GridRow {
                        CategoryButtonView(categoryType: types[rowIndex * 2])
                        CategoryButtonView(categoryType: types[rowIndex * 2 + 1])
                    }
                }
            }
            .frame(maxHeight: .infinity)
        }
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true, alignment: .center)
    }
}
