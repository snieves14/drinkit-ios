//
//  LaunchScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import SwiftUI

struct LaunchScreen: View {
    
    @State private var isLaunchContentVisible = false
    
    var body: some View {
        ZStack {
            Color.surface.ignoresSafeArea()
            if isLaunchContentVisible {
                VStack(spacing: -30) {
                    Image("logo_drinkit")
                        .customImageStyle(width: 300, height: 300)
                    Text("common.appName")
                        .textStyle(font: .bold, size: 40)
                }
                .withTransition(duration: 0.8)
            }
        }
        .task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            withAnimation(.easeInOut(duration: 0.8)) {
                isLaunchContentVisible = true
            }
        }
    }
}
