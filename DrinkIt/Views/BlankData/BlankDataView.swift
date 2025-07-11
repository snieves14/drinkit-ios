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
            VStack(spacing: AppStyle.StackSpacing.large) {
                Text("blankData.title")
                    .textStyle(textAlignment: .center, alignment: .center)
                Button("common.retry") {
                    onAction()
                }.buttonStyle(primaryButtonStyle())
            }
        }
        .withTransition()
    }
}
