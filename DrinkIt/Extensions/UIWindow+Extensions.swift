//
//  UIWindow+Extensions.swift
//  DrinkIt
//
//  Created by Santi Nieves on 10/7/25.
//

import SwiftUI

extension UIWindow {
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowsScene = scene as? UIWindowScene else { continue }
            for window in windowsScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}
