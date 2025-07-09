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
            switch homeState.requestStatus {
            case .success:
                ScrollView {
                    if !homeState.randomCocktails.isEmpty {
                        RandomCocktailsView(randomCocktails: homeState.randomCocktails)
                    }
                    if !homeState.firstLetterCocktails.isEmpty {
                        FirstLetterCocktailsView(firstLetter: homeState.firstLetterCharacter, ingredientCocktails: homeState.firstLetterCocktails)
                    }
                    if !homeState.ingredientCocktails.isEmpty {
                        IngredientCocktailsView(ingredientName: homeState.randomIngredient, ingredientCocktails: homeState.ingredientCocktails)
                    }
                }
                .scrollViewStyle()
                .withTransition()
            case .empty:
                BlankDataView {
                    loadHome()
                }
            default:
                EmptyView()
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.bottom, -6) ///ScrollView flush with the TabBar
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true)
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
