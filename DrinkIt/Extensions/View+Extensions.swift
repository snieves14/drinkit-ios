//
//  View+Extensions.swift
//  DrinkIt
//
//  Created by Santi Nieves on 23/7/25.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}
