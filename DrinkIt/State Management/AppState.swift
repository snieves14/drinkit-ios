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
    
    
    init() {
        print("AppState - init")
    }
}
