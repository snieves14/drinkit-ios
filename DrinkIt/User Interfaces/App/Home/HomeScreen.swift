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
            TabHeaderView(tabHeader: .home)
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
                }
                .scrollViewStyle()
                .withTransition()
            case .empty:
                BlankDataView {
                    loadHome()
                }
                .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            default:
                EmptyView()
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.bottom, -6) ///ScrollView flush with the TabBar
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true, horizontalPadding: 0)
        .onAppear {
            loadHome()
        }
    }
    
    // MARK: - Private functions
    private func loadHome() {
        Task {
            await cocktaildbListsState.listOfIngredients()
            await homeState.loadHome(randomIngredient: cocktaildbListsState.randomIngredientName())
        }
    }
}
