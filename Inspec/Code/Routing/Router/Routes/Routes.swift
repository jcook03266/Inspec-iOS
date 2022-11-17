//
//  Routes.swift
//  Inspec
//
//  Created by Justin Cook on 11/15/22.
//

import Foundation

/// Enums of all possible router routes (views) depending on the router
/// Each router is responsible for a specific set of views that it expects to present somewhere in its view hierarchy, this centralizes the app's navigation pathways to one source of truth
/// Note: Any new views must be added under their respective routes
// MARK: - Onboarding Router
enum OnboardingRoutes: String, CaseIterable, Hashable, Identifiable {
    var id: String {
        String(describing: self)
    }
    
    case onboarding
    case home
    case login
    case signUp
}

// MARK: - Main / Tabbar Router
enum TabbarRoutes: String, CaseIterable, Hashable, Identifiable {
    var id: String {
        String(describing: self)
    }
    
    case builds
    case components
    case command_center
    case explore
    case inbox
}

// MARK: - Builds Router
enum BuildsRoutes: String, CaseIterable, Hashable, Identifiable {
    var id: String {
        String(describing: self)
    }
    
    case main
}
