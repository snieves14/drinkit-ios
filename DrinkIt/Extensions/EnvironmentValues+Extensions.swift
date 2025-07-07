//
//  EnvironmentValues+Extensions.swift
//  DrinkIt
//
//  Created by Santi Nieves on 7/7/25.
//

import SwiftUI

private struct shouldShowTabBarEnvironmentKey: EnvironmentKey {
    static var defaultValue: Binding<Bool> = .constant(true)
}

private struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.first?.safeAreaInsets.edgeInsets ?? EdgeInsets()
    }
}

extension EnvironmentValues {
    var shouldShowTabBar: Binding<Bool> {
        get { self[shouldShowTabBarEnvironmentKey.self] }
        set { self[shouldShowTabBarEnvironmentKey.self] = newValue }
    }
    
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}
