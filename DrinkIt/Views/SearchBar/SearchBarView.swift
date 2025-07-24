//
//  SearchBarView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 24/7/25.
//

import SwiftUI

struct SearchBarView: View {
    
    // MARK: - Properties
    @Binding var searchText: String
    let placeholder: String
    let onAction: () -> Void

    // MARK: - Body
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppStyle.CornerRadius.regular)
                .fill(.surfaceDim)
                .frame(height: 40)
            HStack(spacing: AppStyle.StackSpacing.regular) {
                Image(systemName: "magnifyingglass")
                    .primarySystemImageStyle(size: 15)
                TextField("", text: $searchText, prompt: Text(placeholder.localized()).foregroundColor(.accentContainer))
                    .textStyle(font: .regular)
                if !searchText.isEmpty {
                    Button("") {
                        /// Delay to ensure autocorrect doesn't override the cleared text
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            onAction()
                        }
                    }
                    .buttonStyle(clearSearchButtonStyle())
                }
            }
            .padding(.horizontal, AppStyle.HorizontalPadding.small)
        }
    }
}
