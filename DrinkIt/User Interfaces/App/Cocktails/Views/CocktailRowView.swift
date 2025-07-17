//
//  CocktailRowView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 11/7/25.
//

import SwiftUI

struct CocktailRowView: View {
    
    // MARK: - Properties
    let cocktail: Cocktail
    
    @Environment(AppState.self) var appState
    
    private let cardSize: CGFloat = 50
    

    // MARK: - Body
    var body: some View {
        HStack {
            ZStack {
                KFImageView(imageURL: cocktail.strDrinkThumb?.withDrinkThumbnailSize(.small), imageURLWidth: cardSize, imageURLHeight: cardSize, contentMode: .fill)
                Rectangle()
                    .foregroundColor(Color.shadow.opacity(0.1))
                    .frame(width: cardSize, height: cardSize)
                    .cornerRadius(AppStyle.CornerRadius.regular)
            }
            if let name = cocktail.strDrink {
                Text(name)
                    .textStyle(font: .semiBold, alignment: .leading)
            }
            Spacer()
            Button("") {
                print("CocktailRowView - Tap en favorito")
            }
            .buttonStyle(favButtonStyle(isFavorite: false))
        }
        .contentShape(Rectangle())
        .onTapGesture {
            appState.pushTo(.cocktailsManagement(.cocktailDetailScreen(cocktail: cocktail)))
        }
    }
}
