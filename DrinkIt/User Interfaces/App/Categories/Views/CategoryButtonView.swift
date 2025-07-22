//
//  CategoryButtonView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 22/7/25.
//

import SwiftUI

struct CategoryButtonView: View {
    
    // MARK: - Properties
    let categoryType: CategoryType
    
    @Environment(AppState.self) var appState
    
    // MARK: - Body
    var body: some View {
        Button(categoryType.title) {
            appState.pushTo(.categoriesManagement(.categoryFilterScreen(categoryType: categoryType)))
        }
        .buttonStyle(categoryButtonStyle(image: categoryType.image))
    }
}
