//
//  CategoryCocktailsScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 22/7/25.
//

import SwiftUI

struct CategoryCocktailsScreen: View {
    
    // MARK: - Properties
    let title: String
    let categoryType: CategoryType
   
    // MARK: - Body
    var body: some View {
        VStack {
            Text(categoryType.title)
        }
        .baseViewStyle(tabBar: .hidden, toolBarTitle: title)
    }
}
