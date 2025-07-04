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
            .textStyle(font: .semiBold, size: 17, foregroundColor: disabled ? .surface.opacity(0.5) : .surface)
            .frame(height: 45)
            .frame(maxWidth: .infinity, alignment: alignment)
            .background(disabled ? .accent.opacity(0.5) : .accent)
            .cornerRadius(AppStyle.CornerRadius.regular)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
