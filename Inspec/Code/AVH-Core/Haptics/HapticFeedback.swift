//
//  HapticFeedback.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import CoreHaptics
import UIKit

/// Dispatcher that dispatches specific preconfigured bursts of haptic feedback to further enhance UX
struct HapticFeedbackDispatcher {
    
    static func tabbarButtonPress() {
        Impacts.generateImpact(with: .soft, intensity: 1)
    }
    
    static func arrowButtonPress() {
        Impacts.generateImpact(with: .light, intensity: 0.8)
    }
    
    static func interstitialCTAButtonPress() {
        Impacts.generateImpact(with: .medium, intensity: 0.9)
    }
    
    static func textSectionExpanded() {
        Impacts.generateImpact(with: .light, intensity: 0.5)
    }
    
    struct Impacts{}
}

private extension HapticFeedbackDispatcher.Impacts {
    /// Impact with specific style and intensity from 0 - 1
    static func generateImpact(with style: UIImpactFeedbackGenerator.FeedbackStyle, intensity: CGFloat) {
        let generator = UIImpactFeedbackGenerator(style: style)
    
        generator.prepare()
        generator.impactOccurred(intensity: intensity)
    }
}
