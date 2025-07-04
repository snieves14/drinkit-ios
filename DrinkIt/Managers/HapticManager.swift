//
//  HapticManager.swift
//  DrinkIt
//
//  Created by Santi Nieves on 4/7/25.
//

import UIKit

class HapticManager {
    static let shared = HapticManager()
    
    private init() { }
    
    /// Generates physical impact feedback (e.g., button taps, gestures).
    /// Styles: .light, .medium, .heavy, .soft, .rigid
    /// Use this for interactions like tapping, dragging, etc.
    func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
    
    /// Generates notification-style feedback (e.g., success, warning, error).
    /// Types: .success, .warning, .error
    /// Use this for indicating results or alerts to the user.
    func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
}
