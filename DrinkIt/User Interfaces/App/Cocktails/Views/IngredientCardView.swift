//
//  IngredientCardView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 15/7/25.
//

import SwiftUI

struct IngredientCardView: View {
    
    // MARK: - Properties
    let title: String
    let description: String
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: AppStyle.StackSpacing.small) {
            Text(title)
                .textStyle(size: AppStyle.TextSize.heading2, foregroundColor: .surface, textAlignment: .center, alignment: .center)
            Text(description)
                .textStyle(foregroundColor: .surface, alignment: .leading)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, AppStyle.VerticalPadding.regular)
        .padding(.horizontal, AppStyle.HorizontalPadding.regular)
        .background(
            RoundedRectangle(cornerRadius: AppStyle.CornerRadius.regular)
                .fill(.tertiaryBrand)
        )
    }
}
