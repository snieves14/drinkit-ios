//
//  TabHeaderView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//


import SwiftUI

struct TabHeaderView: View {
    
    // MARK: - Enums
    enum TabHeaderType: String {
        case home
        case categories
        case favorites
        case myIngredients
        case myCocktails

        var id: String { rawValue }

        var title: String {
            rawTitle.localized()
        }

        private var rawTitle: String {
            switch self {
            case .home: return "home.title"
            case .categories: return "categories.title"
            case .favorites: return "favorites.title"
            case .myIngredients: return "myIngredients.title"
            case .myCocktails: return "myCocktails.title"
            }
        }
    }
    
    // MARK: - Properties
    let tabHeader: TabHeaderType
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(tabHeader.title)
                .textStyle(font: .semiBold, size: 27, alignment: .leading, lineLimit: 1, minimumScaleFactor: 0.5)
        }
    }
}
