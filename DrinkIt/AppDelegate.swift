//
//  AppDelegate.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import UIKit
import SwiftUI


class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    // MARK: - Properties
    var searchIcon: UIImage {
        UIImage(systemName: "magnifyingglass")!
            .withTintColor(UIColor(.accent), renderingMode: .alwaysOriginal)
    }

    var clearIcon: UIImage {
        UIImage(systemName: "xmark.circle.fill")!
            .withTintColor(UIColor(.accent), renderingMode: .alwaysOriginal)
    }
    
    // MARK: - Functions
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        /// Set the tint color of UIViews within UIAlertControllers to system blue
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemBlue
        /// Set the tint color of UIViews within UIRefreshControl to veryDarkViolet color
        UIRefreshControl.appearance().tintColor = UIColor(Color.accent)
        /// Set the global appearance of UISearchBar
        UISearchBar.appearance().setImage(searchIcon, for: .search, state: .normal)
        UISearchBar.appearance().setImage(clearIcon, for: .clear, state: .normal)
        UISearchBar.appearance(whenContainedInInstancesOf: [UINavigationBar.self]).tintColor = UIColor.accent
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.surfaceDim
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [.foregroundColor: UIColor.accent, .font: UIFont.preferredFont(forTextStyle: .body)]
        UISearchTextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "", attributes: [.foregroundColor: UIColor.accentContainer])
        ///Set the NavigationBar Appearance
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}
