//
//  UIScreen+Extensions.swift
//  DrinkIt
//
//  Created by Santi Nieves on 10/7/25.
//

import SwiftUI

extension UIScreen {
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
    
    static var width: CGFloat {
        return UIScreen.current?.bounds.size.width ?? 0
    }
    
    static var height: CGFloat {
        return UIScreen.current?.bounds.size.height ?? 0
    }
}
