//
//  NavigationStackModifier.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

enum Route: Hashable {
    
    case cocktailsManagement(CocktailsManagementRoutes)
    
    enum CocktailsManagementRoutes: Hashable, Equatable {
        case cocktailsScreen(cocktailSectionType: CocktailSectionType, cocktails: [Cocktail])
        case cocktailDetailScreen(cocktail: Cocktail)
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(String(describing: self))
        }
        
        static func == (lhs: CocktailsManagementRoutes, rhs: CocktailsManagementRoutes) -> Bool {
            return true
        }
    }
}

struct CocktailsManagementRouter {
    
    let routes: Route.CocktailsManagementRoutes
    
    @ViewBuilder
    func configure() -> some View {
        switch routes {
        case .cocktailsScreen(let cocktailSectionType, let cocktails):
            CocktailsScreen(cocktailSectionType: cocktailSectionType, cocktails: cocktails)
        case .cocktailDetailScreen(let cocktail):
            CocktailDetailScreen(cocktail: cocktail)
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
    func navigationStackModifier() -> some View {
        modifier(NavigationStackModifier())
    }
}
