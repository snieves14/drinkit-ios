//
//  LoaderManager.swift
//  DrinkIt
//
//  Created by Santi Nieves on 8/7/25.
//

import SwiftUI
import Combine

final class LoaderManager {
    static let shared = LoaderManager()
    
    let loaderPublisher = PassthroughSubject<Bool, Never>()
    
    private var activeRequests = 0
    private let queue = DispatchQueue(label: "LoaderManagerQueue")
    private var isLoaderVisible = false
    
    private init() {}
    
    func startRequest(delay: TimeInterval = 0.6) {
        queue.async {
            self.activeRequests += 1
            if self.activeRequests == 1 {
                let effectiveDelay = self.isLoaderVisible ? 0 : delay
                DispatchQueue.main.asyncAfter(deadline: .now() + effectiveDelay) {
                    self.queue.async {
                        if self.activeRequests > 0 {
                            self.loaderPublisher.send(true)
                            self.isLoaderVisible = true
                        }
                    }
                }
            }
        }
    }
    
    func endRequest() {
        queue.async {
            self.activeRequests = max(0, self.activeRequests - 1)
            if self.activeRequests == 0 {
                DispatchQueue.main.async {
                    self.loaderPublisher.send(false)
                    self.isLoaderVisible = false
                }
            }
        }
    }
}
