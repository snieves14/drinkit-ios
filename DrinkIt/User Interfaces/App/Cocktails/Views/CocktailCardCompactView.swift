//
//  CocktailCardCompactView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 10/7/25.
//

import SwiftUI

struct CocktailCardCompactView: View {
    
    // MARK: - Properties
    let cocktail: Cocktail
    
    private let cardWidth: CGFloat = 140
    private let cardHeight: CGFloat = 180
    

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImageView(imageURL: cocktail.strDrinkThumb?.withDrinkThumbnailSize(.small), imageURLWidth: cardWidth, imageURLHeight: cardHeight, contentMode: .fill)
            Rectangle()
                .foregroundColor(Color.shadow.opacity(0.1))
                .frame(width: cardWidth, height: cardHeight)
                .cornerRadius(AppStyle.CornerRadius.regular)

            if let name = cocktail.strDrink {
                Text(name)
                    .textStyle(font: .semiBold, size: 14, foregroundColor: .white, alignment: .leading)
                    .padding([.horizontal, .bottom], 8)
                    .frame(width: cardWidth)
            }
        }
    }
}
