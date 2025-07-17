//
//  TextModifier.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import Foundation
import SwiftUI

struct TextModifier: ViewModifier {
    
    var font: Quicksand
    var size:CGFloat
    var foregroundColor:Color
    var textAlignment:TextAlignment
    var alignment:Alignment?
    var horizontalFixedSize: Bool
    var verticalFixedSize: Bool
    var lineLimit:Int?
    var minimumScaleFactor: CGFloat
    
    func body(content: Content) -> some View {
        if let alignment = alignment {
            content
                .fixedSize(horizontal: horizontalFixedSize, vertical: verticalFixedSize)
                .foregroundColor(foregroundColor)
                .customFontModifier(font: font, size: size)
                .lineLimit(lineLimit)
                .multilineTextAlignment(textAlignment)
                .frame(maxWidth: .infinity, alignment: alignment)
                .minimumScaleFactor(minimumScaleFactor)
        } else {
            content
                .fixedSize(horizontal: horizontalFixedSize, vertical: verticalFixedSize)
                .foregroundColor(foregroundColor)
                .customFontModifier(font: font, size: size)
                .lineLimit(lineLimit)
                .multilineTextAlignment(textAlignment)
                .minimumScaleFactor(minimumScaleFactor)
        }
    }
}

extension View {
    func textStyle(font: Quicksand = .regular, size: CGFloat = AppStyle.TextSize.regular, foregroundColor: Color = .accent, textAlignment: TextAlignment = .leading, alignment: Alignment? = nil, horizontalFixedSize: Bool = false, verticalFixedSize: Bool = true, lineLimit: Int? = nil,  minimumScaleFactor: CGFloat = 1) -> some View {
        self.modifier(TextModifier(font: font, size: size, foregroundColor: foregroundColor, textAlignment: textAlignment, alignment: alignment, horizontalFixedSize: horizontalFixedSize, verticalFixedSize: verticalFixedSize, lineLimit: lineLimit, minimumScaleFactor: minimumScaleFactor))
    }
}
