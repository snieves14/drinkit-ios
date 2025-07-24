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
        case ingredientsSearch
        case cocktailsSearch

        var title: String {
            rawTitle.localized()
        }

        private var rawTitle: String {
            switch self {
            case .home: return "home.title"
            case .categories: return "categories.title"
            case .favorites: return "favorites.title"
            case .ingredientsSearch: return "ingredientsSearch.title"
            case .cocktailsSearch: return "cocktailsSearch.title"
            }
        }
    }
    
    // MARK: - Properties
    let headerType: TabHeaderType
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(headerType.title)
                .textStyle(font: .semiBold, size: AppStyle.TextSize.heading1, alignment: .leading, lineLimit: 1, minimumScaleFactor: 0.5)
        }
    }
}
