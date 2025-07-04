//
//  BaseViewModifier.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import SwiftUI

struct AnimatedTransitionViewModifier: ViewModifier {
    
    var transition: AnyTransition
    var duration: TimeInterval
    
    func body(content: Content) -> some View {
        content
            .transition(
                .asymmetric(
                    insertion: transition.animation(.easeInOut(duration: duration)),
                    removal: transition.animation(.easeInOut(duration: duration))
                )
            )
    }
}

extension View {
    func withTransition(transition: AnyTransition = .opacity, duration: TimeInterval = 0.4) -> some View {
        self.modifier(AnimatedTransitionViewModifier(transition: transition, duration: duration))
    }
}
