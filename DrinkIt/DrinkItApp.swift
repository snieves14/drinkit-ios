//
//  DrinkItApp.swift
//  DrinkIt
//
//  Created by Santi Nieves on 3/7/25.
//

import SwiftUI

@main
struct DrinkItApp: App {
    
    // MARK: - Properties
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var appState = AppState()
    
    @State private var isLaunchScreenVisible = true
    @State private var shouldShowTabBar = true
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.surface.ignoresSafeArea()
                rootViewBuilder
                    .environmentObject(appState)
                    .environment(\.shouldShowTabBar, $shouldShowTabBar)
                    .task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        withAnimation(.easeInOut(duration: 0.8)) {
                            isLaunchScreenVisible = false
                        }
                    }
            }
        }
    }
    
    // MARK: - Root View Builder
    @ViewBuilder
    private var rootViewBuilder: some View {
        Group {
            if isLaunchScreenVisible {
                LaunchScreen()
            } else {
                if appState.hasSeenOnboarding {
                    MainTabScreen()
                } else {
                    OnboardingScreen()
                }
            }
        }
        .withTransition()
    }
}
