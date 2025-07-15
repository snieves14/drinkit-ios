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
    
    // MARK: - Body
    var body: some View {
        VStack {
            switch cocktaildbState.requestStatus {
            case .success:
                ScrollView {
                    VStack(spacing: AppStyle.StackSpacing.large) {
                        if let name = cocktaildbState.cocktail?.strDrink {
                            Text(name)
                                .textStyle(font: .semiBold, size: 14, alignment: .leading)
                        }
                    }
                }
                .scrollViewStyle()
                .withTransition()
            case .empty:
                SecondaryBlankDataView()
            case .failure:
                PrimaryBlankDataView {
                    lookup(refreshPolicy: .always)
                }
                .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            default:
                EmptyView()
            }
        }
        .baseViewStyle(tabBar: .hidden, toolBarTitle: cocktail.strDrink ?? "cocktailDetail.title")
        .padding(.bottom, safeAreaInsets.bottom != 0 ? 0 : -8) ///ScrollView flush with the bottom screen
        .edgesIgnoringSafeArea(.bottom) ///Allows scrolling under the home indicator
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
