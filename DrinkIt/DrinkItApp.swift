//
//  DrinkItApp.swift
//  DrinkIt
//
//  Created by Santi Nieves on 3/7/25.
//

import SwiftUI

@main
struct DrinkItApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var isLaunchScreenVisible = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isLaunchScreenVisible {
                    LaunchScreen()
                } else {
                    OnboardingScreen()
                }
            }
            .task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                withAnimation(.easeInOut(duration: 0.8)) {
                    isLaunchScreenVisible = false
                }
            }
        }
    }
}
