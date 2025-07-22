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

struct categoryButtonStyle: ButtonStyle {
    var image: String
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Image(image)
                .customImageStyle(width: UIScreen.height/12, height: UIScreen.height/12)
            configuration.label
                .textStyle(font: .semiBold, size: AppStyle.TextSize.large, lineLimit: 2, minimumScaleFactor: 0.8)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        }
        .frame(maxWidth: .infinity)
        .frame(height: UIScreen.height/3.3)
        .background(.surfaceDim)
        .cornerRadius(AppStyle.CornerRadius.regular)
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

struct favButtonStyle: ButtonStyle {
    
    var isFavorite: Bool = false
    var primaryColor: Color = .accent
    var size: CGFloat = 18
    
    func makeBody(configuration: Configuration) -> some View {
        Image(systemName: isFavorite ? "heart.fill" : "heart")
            .primarySystemImageStyle(size: size, primaryColor: primaryColor)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
