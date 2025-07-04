//
//  CustomFontModifier.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import SwiftUI

public enum Quicksand: String {
    case bold = "Quicksand-Bold"
    case light = "Quicksand-Light"
    case medium = "Quicksand-Medium"
    case regular = "Quicksand-Regular"
    case semiBold = "Quicksand-SemiBold"
}

struct CustomFontModifier: ViewModifier {
    
    var font:String
    var size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.custom(font, size: size))
    }
}

extension View {
    func customFontModifier(font: Quicksand, size: CGFloat) -> some View {
        self.modifier(CustomFontModifier(font: font.rawValue, size: size))
    }
}
