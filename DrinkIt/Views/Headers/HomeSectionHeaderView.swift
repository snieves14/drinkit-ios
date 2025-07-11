//
//  HomeSectionHeaderView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 11/7/25.
//

import SwiftUI

struct HomeSectionHeaderView: View {
    
    // MARK: - Enums
    enum HomeSectionHeaderType {
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
    }
    
    // MARK: - Properties
    let headerType: HomeSectionHeaderType
    let itemCount: Int
    let onAction: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(headerType.title)
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
