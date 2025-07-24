//
//  CategoryFilterScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 22/7/25.
//

import SwiftUI

struct CategoryFilterScreen: View {
    
    // MARK: - Properties
    let categoryType: CategoryType
    
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @Environment(CocktaildbListsState.self) private var cocktaildbListsState
   
    private var requestStatus: RequestStatus {
        switch categoryType {
        case .ingredients:
            return cocktaildbListsState.ingredientsRequestStatus
        case .alcohol:
            return cocktaildbListsState.alcoholicRequestStatus
        case .styles:
            return cocktaildbListsState.categoriesRequestStatus
        case .glasses:
            return cocktaildbListsState.glassesRequestStatus
        }
    }
    
    private var cocktails: [Cocktail] {
        switch categoryType {
        case .ingredients:
            return cocktaildbListsState.ingredientsList
        case .alcohol:
            return cocktaildbListsState.alcoholicList
        case .styles:
            return cocktaildbListsState.categoriesList
        case .glasses:
            return cocktaildbListsState.glassesList
        }
    }
    
    private var idCocktail: KeyPath<Cocktail, String?> {
        switch categoryType {
        case .ingredients:
            return \.strIngredient1
        case .alcohol:
            return \.strAlcoholic
        case .styles:
            return \.strCategory
        case .glasses:
            return \.strGlass
        }
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            switch requestStatus {
            case .success:
                ScrollView {
                    VStack(spacing: AppStyle.StackSpacing.large) {
                        VStack(alignment: .leading, spacing: AppStyle.ScrollSpacing.regular) {
                            ForEach(cocktails, id: idCocktail) { cocktail in
                                if !cocktailValue(for: cocktail).isEmpty {
                                    CategoryFilterRowView(title: cocktailValue(for: cocktail), categoryType: categoryType)
                                }
                            }
                        }
                        .padding(.bottom, AppStyle.VerticalPadding.xxLarge)
                    }
                }
                .scrollViewStyle()
                .withTransition()
            case .empty:
                SecondaryBlankDataView()
            case .failure:
                PrimaryBlankDataView {
                    listRequest()
                }
            default:
                EmptyView()
            }
        }
        .baseViewStyle(tabBar: .hidden, toolBarTitle: categoryType.title, shouldScrollUnderHomeIndicator: true, bottomPadding: safeAreaInsets.bottom == 0 ? AppStyle.VerticalPadding.zero : AppStyle.VerticalPadding.small)
        .onAppear {
            listRequest()
        }
    }
    
    // MARK: - Private functions
    private func listRequest() {
        Task {
            switch categoryType {
            case .ingredients:
                await cocktaildbListsState.listOfIngredients()
            case .alcohol:
                await cocktaildbListsState.listOfAlcoholic()
            case .styles:
                await cocktaildbListsState.listOfCategories()
            case .glasses:
                await cocktaildbListsState.listOfGlasses()
            }
        }
    }
    
    private func cocktailValue(for cocktail: Cocktail) -> String {
        switch categoryType {
        case .ingredients:
            return cocktail.strIngredient1 ?? ""
        case .alcohol:
            return cocktail.strAlcoholic ?? ""
        case .styles:
            return cocktail.strCategory ?? ""
        case .glasses:
            return cocktail.strGlass ?? ""
        }
    }
}
