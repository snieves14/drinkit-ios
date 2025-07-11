//
//  NavigationStackModifier.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

enum Route: Hashable {
    
    case cocktailsManagement(CocktailsManagementRoutes)
    
    enum CocktailsManagementRoutes: Hashable {
        case cocktailsScreen
        case cocktailDetailScreen
    }
}

struct CocktailsManagementRouter {
    
    let routes: Route.CocktailsManagementRoutes
    
    @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .cocktailsScreen:
            CocktailsScreen()
        case .cocktailDetailScreen:
            CocktailDetailScreen()
        }
    }
}

struct NavigationStackModifier: ViewModifier {
    
    @Environment(\.shouldShowTabBar) var shouldShowTabBar
    
    func body(content: Content) -> some View {
        content
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .cocktailsManagement(let routes):
                    CocktailsManagementRouter(routes: routes).configure()
                        .toolbar(shouldShowTabBar.wrappedValue ? .visible : .hidden, for: .tabBar)
                }
            }
    }
}

extension View {
    /// Adds the `NavigationStackModifier` to the view.
    func navigationStackModifier() -> some View {
        modifier(NavigationStackModifier())
    }
}
