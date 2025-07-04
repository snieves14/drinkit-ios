//
//  AppDelegate.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import UIKit
import SwiftUI


class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        print("AppDelegate - applicationDidFinishLaunching")
        /// Set the tint color of UIViews within UIAlertControllers to system blue
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = .systemBlue
        /// Set the tint color of UIViews within UIRefreshControl to veryDarkViolet color
        UIRefreshControl.appearance().tintColor = UIColor(Color.accent)
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
