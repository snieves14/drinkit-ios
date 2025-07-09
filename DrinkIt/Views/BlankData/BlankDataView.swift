//
//  BlankDataView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 9/7/25.
//

import SwiftUI

struct BlankDataView: View {
    
    // MARK: - Properties
    let onAction: () -> Void
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image("logo_drinkit")
                .customImageStyle(width: 150, height: 150)
            VStack(spacing: 16) {
                Text("blankData.title")
                    .textStyle(font: .regular, textAlignment: .center, alignment: .center)
                Button("common.retry") {
                    onAction()
                }.buttonStyle(primaryButtonStyle())
            }
        }
        .withTransition()
    }
}
