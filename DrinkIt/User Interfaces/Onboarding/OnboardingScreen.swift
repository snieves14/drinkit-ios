//
//  OnboardingScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import SwiftUI

struct OnboardingScreen: View {
    
    // MARK: - Properties
    @Environment(AppState.self) private var appState
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Image("logo_drinkit")
                    .customImageStyle(width: 150, height: 150)
                VStack(spacing: 8) {
                    Text("onboarding.title")
                        .textStyle(font: .medium, size: 26, textAlignment: .center, alignment: .center)
                    Text("onboarding.subtitle")
                        .textStyle(font: .regular, size: 20, textAlignment: .center, alignment: .center)
                }
            }
            Button("common.continue") {
                handleContinueButtonTap()
            }.buttonStyle(primaryButtonStyle())
        }
        .padding(.horizontal, AppStyle.HorizontalPadding.regular)
    }
    
    // MARK: - Private functions
    private func handleContinueButtonTap(){
        HapticManager.shared.notify(.success)
        appState.hasSeenOnboarding = true
    }
}
