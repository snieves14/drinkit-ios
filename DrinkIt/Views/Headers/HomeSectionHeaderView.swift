//
//  HomeSectionHeaderView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 11/7/25.
//

import SwiftUI

struct HomeSectionHeaderView: View {
    
    // MARK: - Properties
    let title: String
    let itemCount: Int
    let onAction: () -> Void
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(title.localized())
                .textStyle(font: .medium, alignment: .leading, lineLimit: 2)
            Spacer()
            if itemCount > 5 {
                Button("common.see_all") {
                    onAction()
                }
                .buttonStyle(pillButtonStyle())
            }
        }
    }
}
