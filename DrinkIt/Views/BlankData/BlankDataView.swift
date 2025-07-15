//
//  BlankDataView.swift
//  DrinkIt
//
//  Created by Santi Nieves on 9/7/25.
//

import SwiftUI

struct PrimaryBlankDataView: View {
    
    // MARK: - Properties
    let onAction: () -> Void
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image("logo_drinkit")
                .customImageStyle(width: 150, height: 150)
            VStack(spacing: AppStyle.StackSpacing.large) {
                Text("blankData.title.primary")
                    .textStyle(textAlignment: .center, alignment: .center)
                Button("common.retry") {
                    onAction()
                }.buttonStyle(primaryButtonStyle())
            }
        }
        .withTransition()
    }
}

struct SecondaryBlankDataView: View {
    
    // MARK: - Body
    var body: some View {
        VStack {
            Image("logo_drinkit")
                .customImageStyle(width: 150, height: 150)
            Text("blankData.title.secondary")
                .textStyle(textAlignment: .center, alignment: .center)
        }
        .withTransition()
    }
}
