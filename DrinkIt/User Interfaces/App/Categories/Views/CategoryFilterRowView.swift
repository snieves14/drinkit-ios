//
//  CategoryFilterRowView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 22/7/25.
//

import SwiftUI

struct CategoryFilterRowView: View {
    
    // MARK: - Properties
    let title: String
    let categoryType: CategoryType
    
    @Environment(AppState.self) var appState
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(title)
                .textStyle(font: .medium, alignment: .leading)
            Spacer()
            Image(systemName: "chevron.right")
                .primarySystemImageStyle(size: 12)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            appState.pushTo(.categoriesManagement(.categoryCocktailsScreen(title: title, categoryType: categoryType)))
        }
    }
}
