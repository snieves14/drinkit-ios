//
//  AppState.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import SwiftUI

@MainActor
class AppState: ObservableObject {
    
    // MARK: - AppStorage(UserDefaults) parameters
    @AppStorage("hasSeenOnboarding") public var hasSeenOnboarding: Bool = false
    
    // MARK: - Routes parameters
    /// This array is composed of 5 elements:
    /// Routes[0] -> Home routes.
    /// Routes[1] -> Categories routes.
    /// Routes[2] -> Favorites routes.
    /// Routes[3] -> MyIngredients  routes.
    /// Routes[4] -> MyCocktails Routes.
    @Published var routes: [[Route]] = []
    @Published var routeIndex = 0
    
    init() {
        print("AppState - init")
        createRoutesArray()
    }
    
    // MARK: - Routes Function
    private func createRoutesArray(){
        routes.append(contentsOf: Array(repeating: [], count: 5))
    }
    
    private func resetRoutesArray() {
        for (index, _) in routes.enumerated() {
            routes[index].removeLast(routes[index].count)
        }
    }
    
    private func resetTabView() {
        routeIndex = 0
        resetRoutesArray()
    }
    
    public func isLastRoute() -> Bool {
        return routes[routeIndex].count == 1
    }
    
    public func pushTo(_ route: Route, delay: CGFloat = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.routes[self.routeIndex].append(route)
        }
    }
    
    public func popTo(_ route: Int = 1, delay: CGFloat = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            if route <= self.routes[self.routeIndex].count {
                self.routes[self.routeIndex].removeLast(route)
            }
        }
    }
    
    public func popToRoot(delay: CGFloat = 0.0) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let count = self.routes[self.routeIndex].count
            self.routes[self.routeIndex].removeLast(count)
        }
    }
    
    public func tabBarItemPopToRoot(currentMainTab: Int) {
        if routeIndex == currentMainTab && routes[routeIndex].count > 0 {
            popToRoot()
        }
    }
}
