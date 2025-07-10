//
//  KFImageView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 10/7/25.
//

import SwiftUI
import Kingfisher

struct KFImageView: View {
    
    // MARK: - Properties
    let imageURL: String?
    let imageURLWidth: CGFloat
    let imageURLHeight: CGFloat
    var fallbackImage: String = "logo_drinkit"
    var fallbackImageSize: CGFloat = 120
    var fallbackBackgroundColor: Color = .accentContainer
    var contentMode: SwiftUI.ContentMode = .fill

    @State private var didFail = false
    
    private var fallbackImageView: some View {
        ZStack {
            fallbackBackgroundColor
            Image(fallbackImage)
                .customImageStyle(width: fallbackImageSize, height: fallbackImageSize)
        }
        .frame(width: imageURLWidth, height: imageURLHeight)
        .cornerRadius(AppStyle.CornerRadius.regular)
    }

    // MARK: - Body
    var body: some View {
        if let urlString = imageURL, let url = URL(string: urlString) {
            if didFail {
                fallbackImageView
            } else {
                KFImage(url)
                    .resizable()
                    .placeholder {
                        fallbackBackgroundColor.opacity(0.2)
                    }
                    .onFailure { _ in
                        didFail = true
                    }
                    .aspectRatio(contentMode: contentMode)
                    .frame(width: imageURLWidth, height: imageURLHeight)
                    .clipped()
                    .cornerRadius(AppStyle.CornerRadius.regular)
            }
        } else {
            fallbackImageView
        }
    }
}
