//
//  HomeScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

struct HomeScreen: View {
    
    // MARK: - Properties
    @StateObject private var cocktaildbState = CocktaildbState()
    
    // MARK: - Body
    var body: some View {
        VStack {
            TabHeaderView(tabHeader: .home)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true)
        .onAppear {
            fetchRandomCocktail()
        }
    }
    
    // MARK: - Private functions
    private func fetchRandomCocktail() {
        Task {
            await cocktaildbState.random()
        }
    }
}
