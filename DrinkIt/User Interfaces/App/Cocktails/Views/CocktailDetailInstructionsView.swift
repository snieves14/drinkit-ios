//
//  CocktailDetailInstructionsView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 17/7/25.
//

import SwiftUI

struct CocktailDetailInstructionsView: View {
    
    // MARK: - Properties
    let cocktail: Cocktail?
    
    // MARK: - Body
    var body: some View {
        if let instructions = cocktail?.localizedInstructions {
            VStack(spacing: AppStyle.StackSpacing.small) {
                Text("cocktailDetail.instructions")
                    .textStyle(font: .medium, size: AppStyle.TextSize.large, alignment: .leading)
                Text(instructions)
                    .textStyle(font: .regular, alignment: .leading)
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: AppStyle.CornerRadius.regular)
                    .fill(.surfaceDim)
            )
        }
    }
}
