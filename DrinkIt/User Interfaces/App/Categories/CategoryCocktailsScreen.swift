//
//  CategoryCocktailsScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 22/7/25.
//

import SwiftUI

struct CategoryCocktailsScreen: View {
    
    // MARK: - Properties
    let title: String
    let categoryType: CategoryType
   
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State private var cocktaildbState = CocktaildbState()
    
    // MARK: - Body
    var body: some View {
        VStack {
            switch cocktaildbState.requestStatus {
            case .success:
                ScrollView {
                    VStack(spacing: AppStyle.StackSpacing.large) {
                        VStack(alignment: .leading, spacing: AppStyle.ScrollSpacing.small) {
                            ForEach(cocktaildbState.cocktails, id: \.idDrink) { cocktail in
                                CocktailRowView(cocktail: cocktail)
                            }
                        }
                        .padding(.bottom, AppStyle.VerticalPadding.extraLarge)
                    }
                }
                .scrollViewStyle()
                .withTransition()
            case .empty:
                SecondaryBlankDataView()
            case .failure:
                PrimaryBlankDataView {
                    filterRequest()
                }
            default:
                EmptyView()
            }
        }
        .baseViewStyle(tabBar: .hidden, toolBarTitle: title)
        .padding(.bottom, safeAreaInsets.bottom != 0 ? 0 : -8) ///ScrollView flush with the bottom screen
        .edgesIgnoringSafeArea(.bottom) ///Allows scrolling under the home indicator
        .onAppear {
            filterRequest()
        }
    }
    
    // MARK: - Private functions
    private func filterRequest() {
        Task {
            await cocktaildbState.filterBy(for: categoryType, value: title)
        }
    }
}
