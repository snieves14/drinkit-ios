//
//  AppState.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import SwiftUI
import Combine
import ObservableUserDefault

@MainActor
@Observable
final class AppState {
    
    // MARK: - ObservableUserDefault properties
    @ObservableUserDefault(.init(key: "hasSeenOnboarding", defaultValue: false, store: .standard))
    @ObservationIgnored
    var hasSeenOnboarding: Bool
    
    // MARK: - Routes properties
    /// This array is composed of 5 elements:
    /// Routes[0] -> Home routes.
    /// Routes[1] -> Categories routes.
    /// Routes[2] -> Favorites routes.
    /// Routes[3] -> IngredientsSearch  routes.
    /// Routes[4] -> MyCocktails Routes.
    var routes: [[Route]] = []
    var routeIndex = 0
    
    // MARK: - LoaderManager properties
    var isLoaderPresented: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        createRoutesArray()
        
        LoaderManager.shared.loaderPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] show in
                self?.isLoaderPresented = show
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Routes Functions
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
