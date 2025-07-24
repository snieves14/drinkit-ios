//
//  CocktailDetailScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 11/7/25.
//

import SwiftUI

struct CocktailDetailScreen: View {
    
    // MARK: - Properties
    let cocktail: Cocktail
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State private var cocktaildbState = CocktaildbState()
    
    private var cardWidth: CGFloat {
        UIScreen.width - (2 * AppStyle.HorizontalPadding.regular)
    }
    private let cardHeight: CGFloat = UIScreen.height/4
    
    // MARK: - Body
    var body: some View {
        VStack {
            switch cocktaildbState.requestStatus {
            case .success:
                ScrollView {
                    VStack(spacing: AppStyle.StackSpacing.large) {
                        KFImageView(imageURL: cocktail.strDrinkThumb?.withDrinkThumbnailSize(.large), imageURLWidth: cardWidth, imageURLHeight: cardHeight, contentMode: .fill)
                        CocktailDetailInfoView(cocktail: cocktaildbState.cocktail)
                        CocktailDetailInstructionsView(cocktail: cocktaildbState.cocktail)
                        CocktailDetailIngredientsView(cocktail: cocktaildbState.cocktail)
                    }
                    .padding(.bottom, AppStyle.VerticalPadding.extraLarge)
                }
                .scrollViewStyle()
                .withTransition()
            case .empty:
                SecondaryBlankDataView()
            case .failure:
                PrimaryBlankDataView {
                    lookup(refreshPolicy: .always)
                }
            default:
                EmptyView()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                FavoriteButtonView(cocktail: cocktail)
            }
        }
        .baseViewStyle(tabBar: .hidden, toolBarTitle: cocktail.strDrink ?? "cocktailDetail.title", shouldScrollUnderHomeIndicator: true, bottomPadding: safeAreaInsets.bottom == 0 ? AppStyle.VerticalPadding.zero : AppStyle.VerticalPadding.small)
        .onAppear {
            lookup()
        }
    }
    
    // MARK: - Private functions
    private func lookup(refreshPolicy: RefreshPolicy = .ifNeeded) {
        guard let idDrink = cocktail.idDrink else {
            cocktaildbState.requestStatus = .failure
            return
        }
        Task {
            await cocktaildbState.lookup(refreshPolicy: refreshPolicy, idDrink: idDrink)
        }
    }
}
