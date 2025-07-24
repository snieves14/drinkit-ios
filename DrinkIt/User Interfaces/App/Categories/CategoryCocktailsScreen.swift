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
    
    @State private var searchText: String = ""
    private var filteredCocktails: [Cocktail] {
        guard !searchText.isEmpty else { return cocktaildbState.cocktails }
        return cocktaildbState.cocktails.filter {
            $0.strDrink?.localizedCaseInsensitiveContains(searchText) == true
        }
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            switch cocktaildbState.requestStatus {
            case .success:
                ScrollView {
                    if filteredCocktails.isEmpty {
                        SecondaryBlankDataView(title: "blankData.title.emptySearch")
                    } else {
                        VStack(spacing: AppStyle.StackSpacing.large) {
                            VStack(alignment: .leading, spacing: AppStyle.ScrollSpacing.small) {
                                ForEach(filteredCocktails, id: \.idDrink) { cocktail in
                                    CocktailRowView(cocktail: cocktail)
                                }
                            }
                            .padding(.bottom, AppStyle.VerticalPadding.xxLarge)
                        }
                        .withTransition()
                    }
                }
                .scrollViewStyle()
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
        .baseViewStyle(tabBar: .hidden, toolBarTitle: title, shouldScrollUnderHomeIndicator: true, bottomPadding: safeAreaInsets.bottom == 0 ? AppStyle.VerticalPadding.zero : AppStyle.VerticalPadding.small)
        .if(cocktaildbState.requestStatus == .success || cocktaildbState.requestStatus == .unknown) {
            $0
                .searchable(text: $searchText)
                .scrollDismissesKeyboard(.immediately)
        }
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
