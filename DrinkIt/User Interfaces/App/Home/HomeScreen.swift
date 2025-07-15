//
//  HomeScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

struct HomeScreen: View {
    
    // MARK: - Properties
    @Environment(CocktaildbListsState.self) private var cocktaildbListsState
    
    @State private var homeState = HomeState()
    
    // MARK: - Body
    var body: some View {
        VStack {
            TabHeaderView(headerType: .home)
                .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            switch homeState.requestStatus {
            case .success:
                ScrollView {
                    VStack(spacing: AppStyle.ScrollSpacing.large) {
                        if !homeState.randomCocktails.isEmpty {
                            RandomCocktailsView(cocktails: homeState.randomCocktails)
                        }
                        if !homeState.firstLetterCocktails.isEmpty {
                            FirstLetterCocktailsView(firstLetter: homeState.firstLetterCharacter, cocktails: homeState.firstLetterCocktails)
                        }
                        if !homeState.ingredientCocktails.isEmpty {
                            IngredientCocktailsView(ingredientName: homeState.randomIngredient, cocktails: homeState.ingredientCocktails)
                        }
                    }
                    .padding(.bottom, AppStyle.VerticalPadding.regular)
                }
                .refreshable {
                    loadHome(refreshPolicy: .always)
                }
                .scrollViewStyle()
                .withTransition()
            case .empty:
                PrimaryBlankDataView {
                    loadHome(refreshPolicy: .always)
                }
                .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            default:
                EmptyView()
            }
        }
        .padding(.bottom, -6) ///ScrollView flush with the TabBar
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true, horizontalPadding: 0)
        .onAppear {
            loadHome()
        }
    }
    
    // MARK: - Private functions
    private func loadHome(refreshPolicy: RefreshPolicy = .ifNeeded) {
        Task {
            await cocktaildbListsState.listOfIngredients()
            await homeState.loadHome(refreshPolicy: refreshPolicy, randomIngredient: cocktaildbListsState.randomIngredientName())
        }
    }
}
