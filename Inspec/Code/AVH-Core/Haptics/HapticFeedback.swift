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
