//
//  LoaderModifier.swift
//  DrinkIt
//
//  Created by Santi Nieves on 8/7/25.
//

import SwiftUI

struct LoaderView: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.secondaryContainer)
                .frame(width: 85, height: 85)
            Circle()
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [.white, .accentContainer]),
                        center: .center
                    ),
                    lineWidth: 2
                )
                .frame(width: 45, height: 45)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: UUID())
        }
        .onAppear {
            self.isAnimating = true
        }
    }
}


struct LoaderModifier: ViewModifier {
    
    @EnvironmentObject var appState: AppState
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if appState.isLoaderPresented {
                    Color.clear
                        .ignoresSafeArea()
                        .overlay(LoaderView(), alignment: .center)
                }
            }
            .disabled(appState.isLoaderPresented)
    }
}

extension View {
    
    func loaderModifier() -> some View {
        modifier(LoaderModifier())
    }
}
