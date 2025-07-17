//
//  ButtonStyle.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import SwiftUI

struct primaryButtonStyle: ButtonStyle {
    
    var alignment: Alignment = .center
    var disabled: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textStyle(font: .semiBold, size: AppStyle.TextSize.large, foregroundColor: disabled ? .surface.opacity(0.5) : .surface)
            .frame(height: 45)
            .frame(maxWidth: .infinity, alignment: alignment)
            .background(disabled ? .accent.opacity(0.5) : .accent)
            .cornerRadius(AppStyle.CornerRadius.regular)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct tabItemButtonStyle : ButtonStyle {
    
    var image: String
    var isActive: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 10){
            Spacer()
            Image(image)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .accent : .surface)
                .frame(width: 25, height: 25)
            Spacer()
        }
        .background(.clear)
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct pillButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .textStyle(size: AppStyle.TextSize.small, foregroundColor: .surface)
            .padding(.horizontal, AppStyle.HorizontalPadding.regular)
            .frame(height: 30)
            .background(.tertiaryBrand)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
