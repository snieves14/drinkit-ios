//
//  CocktailDetailInfoView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 17/7/25.
//

import SwiftUI

// MARK: - Enums
private enum CocktailDetailSectionType {
    case category
    case iba
    case alcoholic
    case glass
    
    var title: String {
        rawTitle.localized()
    }
    
    private var rawTitle: String {
        switch self {
        case .alcoholic: return "cocktailDetail.alcoholic"
        case .glass: return "cocktailDetail.glass"
        case .category: return "cocktailDetail.category"
        case .iba: return "cocktailDetail.iba"
        }
    }
}

struct CocktailDetailInfoView: View {
    
    // MARK: - Properties
    let cocktail: Cocktail?
    
    // MARK: - Body
    var body: some View {
        if let name = cocktail?.strDrink {
            Text(name)
                .textStyle(font: .bold, size: AppStyle.TextSize.heading3, alignment: .leading)
        }
        VStack(spacing: AppStyle.StackSpacing.regular) {
            detailSection(cocktailDetailSectionType: .category, value: cocktail?.strCategory)
            detailSection(cocktailDetailSectionType: .iba, value: cocktail?.strIBA)
            detailSection(cocktailDetailSectionType: .alcoholic, value: cocktail?.strAlcoholic)
            detailSection(cocktailDetailSectionType: .glass, value: cocktail?.strGlass)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: AppStyle.CornerRadius.regular)
                .fill(.surfaceDim)
        )
    }
    
    // MARK: - Private functions
    private func detailSection(cocktailDetailSectionType: CocktailDetailSectionType, value: String?) -> some View {
        Group {
            if let value {
                VStack(spacing: AppStyle.StackSpacing.small) {
                    Text(cocktailDetailSectionType.title)
                        .textStyle(font: .medium, size: AppStyle.TextSize.large, alignment: .leading)
                    Text(value)
                        .textStyle(font: .regular, alignment: .leading)
                }
            }
        }
    }
}
