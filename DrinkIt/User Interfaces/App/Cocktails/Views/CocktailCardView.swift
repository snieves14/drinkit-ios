//
//  CocktailCardView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 10/7/25.
//

import SwiftUI

struct CocktailCardView: View {
    
    // MARK: - Properties
    let cocktail: Cocktail
    
    @Environment(AppState.self) var appState

    private var cardWidth: CGFloat {
        UIScreen.width - (2 * AppStyle.HorizontalPadding.regular)
    }
    private let cardHeight: CGFloat = 180

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                KFImageView(imageURL: cocktail.strDrinkThumb?.withDrinkThumbnailSize(.medium), imageURLWidth: cardWidth, imageURLHeight: cardHeight, contentMode: .fill)
                Rectangle()
                    .foregroundColor(Color.shadow.opacity(0.1))
                    .frame(width: cardWidth, height: cardHeight)
                    .cornerRadius(AppStyle.CornerRadius.large)

                if let name = cocktail.strDrink {
                    VStack(spacing: AppStyle.StackSpacing.small) {
                        Text(name)
                            .textStyle(font: .semiBold, foregroundColor: .white, alignment: .leading)
                        Text(cocktail.ingredientNames)
                            .textStyle(font: .regular, size: AppStyle.TextSize.small, foregroundColor: .white, alignment: .leading, lineLimit: 3)
                    }
                    .padding([.horizontal, .bottom], 8)
                    .frame(width: cardWidth, alignment: .leading)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                appState.pushTo(.cocktailsManagement(.cocktailDetailScreen(cocktail: cocktail)))
            }
            FavoriteButtonView(cocktail: cocktail, primaryColor: .white, size: 27)
            .padding(AppStyle.Padding.regular)
        }
    }
}
