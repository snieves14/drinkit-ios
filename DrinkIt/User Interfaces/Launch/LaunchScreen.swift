//
//  LaunchScreen.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import SwiftUI

struct LaunchScreen: View {
    
    // MARK: - Properties
    @State private var isLaunchContentVisible = false
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: -30) {
            if isLaunchContentVisible {
                Image("logo_drinkit")
                    .customImageStyle(width: 300, height: 300)
                Text("common.appName")
                    .textStyle(font: .bold, size: 40)
            }
        }
        .padding(.horizontal, AppStyle.HorizontalPadding.large)
        .withTransition(duration: 0.8)
        .task {
            try? await Task.sleep(nanoseconds: 500_000_000)
            withAnimation(.easeInOut(duration: 0.8)) {
                isLaunchContentVisible = true
            }
        }
        
    }
}
