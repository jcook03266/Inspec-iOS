//
//  LaunchScreenManager.swift
//  Inspec
//
//  Created by Justin Cook on 11/22/22.
//

import Foundation

/// Manages the lifecycle and states of the launch screen
class LaunchScreenManager {
    
    // MARK: - Life Cycle Properties
    // In seconds [s]
    static var displayDuration: CGFloat = 5
    
    init() {}
    
    /// Closure to be run when the launch screen is done being displayed
    func onComplete(execute task: @escaping (() -> Void)) {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + LaunchScreenManager.displayDuration) {
            task()
        }
    }
}
