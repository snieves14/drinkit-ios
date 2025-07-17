//
//  ImageModifier.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import SwiftUI

protocol ImageModifier {
    /// `Body` is derived from `View`
    associatedtype Body : View
    
    /// Modify an image by applying any modifications into `some View`
    func body(image: Image) -> Self.Body
}

extension Image {
    func modifier<M>(_ modifier: M) -> some View where M: ImageModifier {
        modifier.body(image: self)
    }
}

struct CustomImageModifier: ImageModifier {
    
    var foregroundColor:Color
    var backgroundColor:Color
    var width:CGFloat
    var height:CGFloat
    var contentMode:ContentMode
    
    func body(image: Image) -> some View {
        image
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: contentMode)
            .frame(width: width, height: height)
            .foregroundColor(foregroundColor)
            .background(backgroundColor)
    }
}

struct PrimarySystemImageModifier: ImageModifier {
    
    var size: CGFloat
    var primaryColor: Color
    
    func body(image: Image) -> some View {
        image
            .symbolRenderingMode(.palette)
            .foregroundStyle(primaryColor)
            .font(.system(size: size))
    }
}

struct SecondarySystemImageModifier: ImageModifier {
    
    var size: CGFloat
    var primaryColor: Color
    var secondaryColor: Color
    
    func body(image: Image) -> some View {
        image
            .symbolRenderingMode(.palette)
            .foregroundStyle(primaryColor, secondaryColor)
            .font(.system(size: size))
    }
}

struct TertiarySystemImageModifier: ImageModifier {
    
    var size: CGFloat
    var primaryColor: Color
    var secondaryColor: Color
    var tertiaryColor: Color
    
    func body(image: Image) -> some View {
        image
            .symbolRenderingMode(.palette)
            .foregroundStyle(primaryColor, secondaryColor, tertiaryColor)
            .font(.system(size: size))
    }
}

extension Image {
    func customImageStyle(foregroundColor:Color = .accent, backgroundColor:Color = .clear, width: CGFloat = 30, height: CGFloat = 30, contentMode:ContentMode = .fit) -> some View {
        self.modifier(CustomImageModifier(foregroundColor: foregroundColor, backgroundColor: backgroundColor, width: width, height: height, contentMode: contentMode))
    }
    
    func primarySystemImageStyle(size: CGFloat = 30, primaryColor: Color = .accent) -> some View {
        self.modifier(PrimarySystemImageModifier(size: size, primaryColor: primaryColor))
    }
    
    func secondarySystemImageStyle(size: CGFloat = 30, primaryColor: Color = .accent, secondaryColor: Color = .accent) -> some View {
        self.modifier(SecondarySystemImageModifier(size: size, primaryColor: primaryColor, secondaryColor: secondaryColor))
    }
    
    func tertiarySystemImageStyle(size: CGFloat = 30, primaryColor: Color = .accent, secondaryColor: Color = .accent, tertiaryColor: Color = .accent) -> some View {
        self.modifier(TertiarySystemImageModifier(size: size, primaryColor: primaryColor, secondaryColor: secondaryColor, tertiaryColor: tertiaryColor))
    }
}
