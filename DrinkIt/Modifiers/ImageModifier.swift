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

extension Image {
    func customImageStyle(foregroundColor:Color = .accent, backgroundColor:Color = .clear, width: CGFloat = 30, height: CGFloat = 30, contentMode:ContentMode = .fit) -> some View {
        self.modifier(CustomImageModifier(foregroundColor: foregroundColor, backgroundColor: backgroundColor, width: width, height: height, contentMode: contentMode))
    }
}
