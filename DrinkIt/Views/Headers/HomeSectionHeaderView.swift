//
//  HomeSectionHeaderView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 11/7/25.
//

import SwiftUI

// MARK: - Enums
public enum CocktailSectionType {
    case random
    case firstLetter(Character)
    case ingredient(String)
    
    var title: String {
        switch self {
        case .random:
            return "randomCocktails.title".localized()
        case .firstLetter(let char):
            return "firstLetterCocktails.title".localizedWithArguments(arguments: String(char).uppercased())
        case .ingredient(let name):
            return "ingredientCocktails.title".localizedWithArguments(arguments: name)
        }
    }
    
    var ingredientName: String? {
        if case .ingredient(let name) = self {
            return name
        }
        return nil
    }
}

struct HomeSectionHeaderView: View {
    
    // MARK: - Properties
    let cocktailSectionType: CocktailSectionType
    let itemCount: Int
    let onAction: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(cocktailSectionType.title)
                .textStyle(font: .medium, alignment: .leading, lineLimit: 2)
            Spacer()
            if itemCount > 5 {
                Button("common.see_all") {
                    onAction()
                }
                .buttonStyle(pillButtonStyle())
            }
        }
    }
}
