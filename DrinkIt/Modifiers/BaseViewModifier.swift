//
//  BaseViewModifier.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import SwiftUI

struct BaseViewModifier: ViewModifier {
    
    var tabBar: Visibility
    var toolBarTitle: String
    var isBackButtonHidden: Bool
    var isTitleHidden: Bool
    var popTo: Int
    var alignment: Alignment
    var verticalPadding: CGFloat?
    var horizontalPadding: CGFloat?
    
    @Environment(\.shouldShowTabBar) var shouldShowTabBar
    
    func body(content: Content) -> some View {
        ZStack {
            Color.surface.edgesIgnoringSafeArea(.all)
            content
                .frame(maxHeight: .infinity, alignment: alignment)
                .padding(.vertical, verticalPadding ?? AppStyle.VerticalPadding.small)
                .padding(.horizontal, horizontalPadding ?? AppStyle.HorizontalPadding.regular)
        }
        .toolbarStyle(title: toolBarTitle, isBackButtonHidden: isBackButtonHidden, isTitleHidden: isTitleHidden, popTo: popTo)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onAppear {
            shouldShowTabBar.wrappedValue = tabBar == .visible ? true : false
        }
    }
}

struct ToolbarViewModifier: ViewModifier {
    
    var title: String
    var isBackButtonHidden: Bool
    var isTitleHidden: Bool
    var popTo: Int
    
    @Environment(\.shouldShowTabBar) var shouldShowTabBar
    @Environment(AppState.self) var appState
    
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if !isBackButtonHidden {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            if popTo == -1 {
                                ///Code to control a delay when visibility changes in the tabBar
                                shouldShowTabBar.wrappedValue = true
                                appState.popToRoot(delay: 0.05)
                            } else {
                                ///Code to control a delay when visibility changes in the tabBar
                                if appState.isLastRoute() {
                                    shouldShowTabBar.wrappedValue = true
                                    appState.popToRoot(delay: 0.05)
                                } else {
                                    appState.popTo(popTo)
                                }
                            }
                        } label: {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.accent)
                        }
                    }
                }
                if !isTitleHidden {
                    ToolbarItem(placement: .principal) {
                        Text(title.localized())
                            .textStyle(font: .semiBold, size: 18, lineLimit: 1, minimumScaleFactor: 0.5)
                    }
                }
            }
    }
}

struct ScrollViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.hidden)
    }
}

struct AnimatedTransitionViewModifier: ViewModifier {
    
    var transition: AnyTransition
    var duration: TimeInterval
    
    func body(content: Content) -> some View {
        content
            .transition(
                .asymmetric(
                    insertion: transition.animation(.easeInOut(duration: duration)),
                    removal: transition
                )
            )
    }
}

extension View {
    
    public func baseViewStyle(tabBar: Visibility = .visible, toolBarTitle: String = "", isBackButtonHidden: Bool = false, isTitleHidden: Bool = false, popTo: Int = 1, alignment: Alignment = .top, verticalPadding: CGFloat? = nil, horizontalPadding: CGFloat? = nil) -> some View {
        modifier(BaseViewModifier(tabBar: tabBar, toolBarTitle: toolBarTitle, isBackButtonHidden: isBackButtonHidden, isTitleHidden: isTitleHidden, popTo: popTo, alignment: alignment, verticalPadding: verticalPadding, horizontalPadding: horizontalPadding))
    }
    
    fileprivate func toolbarStyle(title: String = "", isBackButtonHidden : Bool = false, isTitleHidden : Bool = false, popTo: Int = 1) -> some View {
        self.modifier(ToolbarViewModifier(title: title, isBackButtonHidden: isBackButtonHidden, isTitleHidden: isTitleHidden, popTo: popTo))
    }
    
    public func scrollViewStyle() -> some View {
        self.modifier(ScrollViewModifier())
    }
    
    public func withTransition(transition: AnyTransition = .opacity, duration: TimeInterval = 0.4) -> some View {
        self.modifier(AnimatedTransitionViewModifier(transition: transition, duration: duration))
    }
}
