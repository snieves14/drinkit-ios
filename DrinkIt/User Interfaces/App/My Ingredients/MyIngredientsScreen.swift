//
//  MyIngredientsScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI
import Combine

struct MyIngredientsScreen: View {
    
    // MARK: - Properties
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State private var cocktaildbState = CocktaildbState()
    
    @State private var filterCancellable: AnyCancellable?
    
    // MARK: - Body
    var body: some View {
        VStack {
            TabHeaderView(headerType: .myIngredients)
            VStack(spacing: AppStyle.StackSpacing.regular) {
                SearchBarView(searchText: $cocktaildbState.searchText, placeholder: "myIngredients.search") {
                    cocktaildbState.searchText = ""
                    cocktaildbState.resetFilterResults()
                }
                switch cocktaildbState.requestStatus {
                case .success:
                    ScrollView {
                        if cocktaildbState.cocktails.isEmpty {
                            SecondaryBlankDataView(title: "blankData.title.emptySearch")
                        } else {
                            VStack(spacing: AppStyle.StackSpacing.large) {
                                VStack(alignment: .leading, spacing: AppStyle.ScrollSpacing.small) {
                                    ForEach(cocktaildbState.cocktails, id: \.idDrink) { cocktail in
                                        CocktailRowView(cocktail: cocktail)
                                    }
                                }
                                .padding(.bottom, AppStyle.VerticalPadding.regular)
                            }
                            .withTransition()
                        }
                    }
                    .scrollViewStyle()
                    .scrollDismissesKeyboard(.immediately)
                case .empty:
                    SecondaryBlankDataView(title: "blankData.title.emptySearch")
                case .failure:
                    SecondaryBlankDataView()
                default:
                    SecondaryBlankDataView(title: "blankData.title.myIngredients")
                }
            }
        }
        .baseViewStyle(isBackButtonHidden: true, isTitleHidden: true, bottomPadding: safeAreaInsets.bottom == 0 ? AppStyle.VerticalPadding.xxxLarge : AppStyle.VerticalPadding.large)
        .onAppear {
            filterCancellable = cocktaildbState.filterByPublisher(for: .ingredients)
        }
    }
}
