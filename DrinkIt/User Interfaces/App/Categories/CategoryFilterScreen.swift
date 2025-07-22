//
//  CategoryFilterScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 22/7/25.
//

import SwiftUI

struct CategoryFilterScreen: View {
    
    // MARK: - Properties
    let categoryType: CategoryType
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(categoryType.title)
        }
        .baseViewStyle(tabBar: .hidden, toolBarTitle: categoryType.title)
    }
}
