//
//  RandomCocktailCardView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 10/7/25.
//

import SwiftUI

struct RandomCocktailCardView: View {
    
    // MARK: - Properties
    let cocktail: Cocktail

    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            KFImageView(imageURL: cocktail.strDrinkThumb?.withDrinkThumbnailSize(.small), imageURLWidth: 140, imageURLHeight: 180, contentMode: .fill)
            Rectangle()
                .foregroundColor(Color.shadow.opacity(0.1))
                .frame(width: 140, height: 180)
                .cornerRadius(AppStyle.CornerRadius.regular)

            if let name = cocktail.strDrink {
                Text(name)
                    .textStyle(font: .semiBold, size: 14, foregroundColor: .white, alignment: .leading)
                    .padding([.horizontal, .bottom], 8)
                    .frame(width: 140)
            }
        }
    }
}
