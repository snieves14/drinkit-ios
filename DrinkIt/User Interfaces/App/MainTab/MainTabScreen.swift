//
//  MainTabScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import SwiftUI

// MARK: - Enums
private enum TabbedItems: Int, CaseIterable {
    case home = 0
    case categories
    case favorites
    case myIngredients
    case myCocktails

    var iconName: String {
        switch self {
        case .home: return "icon_tab_home"
        case .categories: return "icon_tab_categories"
        case .favorites: return "icon_tab_favorites"
        case .myIngredients: return "icon_tab_my_ingredients"
        case .myCocktails: return "icon_tab_my_cocktails"
        }
    }
}

struct MainTabScreen: View {
    
    // MARK: - Properties
    @Environment(\.safeAreaInsets) var safeAreaInsets
    @Environment(\.shouldShowTabBar) var shouldShowTabBar
    @EnvironmentBindable<AppState> private var appState
    
    // MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom){
            TabView(selection: $appState.routeIndex) {
                NavigationStack(path: $appState.routes[0]){
                    HomeScreen()
                        .navigationStackModifier()
                }.tag(0)
                NavigationStack(path: $appState.routes[1]){
                    CategoriesScreen()
                        .navigationStackModifier()
                }.tag(1)
                NavigationStack(path: $appState.routes[2]){
                    FavoritesScreen()
                        .navigationStackModifier()
                }.tag(2)
                NavigationStack(path: $appState.routes[3]){
                    MyIngredientsScreen()
                        .navigationStackModifier()
                }.tag(3)
                NavigationStack(path: $appState.routes[4]){
                    MyCocktailsScreen()
                        .navigationStackModifier()
                }.tag(4)
            }
            if !shouldShowTabBar.wrappedValue {
                EmptyView()
            } else {
                ZStack {
                    RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .fill(.accentContainer)
                        .shadow(color: .shadow.opacity(0.1), radius: 10, x: 0, y: -2)
                    HStack {
                        ForEach(TabbedItems.allCases, id: \.self) { item in
                            Button("") {
                                appState.tabBarItemPopToRoot(currentMainTab: item.rawValue)
                                appState.routeIndex = item.rawValue
                            }
                            .buttonStyle(tabItemButtonStyle(image: item.iconName, isActive: appState.routeIndex == item.rawValue))
                        }
                    }
                    .padding(.bottom, safeAreaInsets.bottom == 0 ? 0 : 20)
                }
                .frame(height: safeAreaInsets.bottom == 0 ? 80 : 100)
                .padding(.bottom, safeAreaInsets.bottom == 0 ? 0 : -35)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
