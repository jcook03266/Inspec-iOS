//
//  Colors.swift
//  Inspec
//
//  Created by Justin Cook on 10/28/22.
//

import Foundation
import SwiftUI
import UIKit

/// Simplified and organized way of referencing the colors stored in the Colors assets directory.
/// Note: If a new color is added, update the respective test in ResourcesTests.swift
struct Colors {
    static func getColor(named colorName: IterableColors) -> Color {
        let color = Color(getUIColor(named: colorName))
        
        return color
    }
    
    static func getUIColor(named colorName: IterableColors) -> UIColor {
        guard let uiColor = UIColor(named: colorName.rawValue) else {
            preconditionFailure("Error: The color named \(colorName) was not found")
        }
        
        return uiColor
    }
    
    static func getUIColors(named color1: IterableColors, color2: IterableColors) -> (UIColor, UIColor) {
        guard let uiColor1 = UIColor(named: color1.rawValue),
                let uiColor2 = UIColor(named: color2.rawValue) else {
            preconditionFailure("Error: One of the colors named [\(color1), \(color2)] were not found")
        }

        return (uiColor1, uiColor2)
    }
    
    static func getColors(named color1: IterableColors, color2: IterableColors) -> (Color, Color) {
        let uiColors = getUIColors(named: color1, color2: color2)

        return (Color(uiColors.0), Color(uiColors.1))
    }
    
    static func getLinearGradient(named gradientName: IterableGradients) -> LinearGradient {
        switch gradientName {
        case .gradient_1:
            let colors = getColors(named: .primary_1, color2: .secondary_1)
            let startPoint = UnitPoint(x: 0, y: 1)
            let endPoint = UnitPoint(x: 1, y: 0)
            
            return LinearGradient(colors: [colors.0, colors.1],
                                  startPoint: startPoint,
                                  endPoint: endPoint)
        case .gradient_2:
            let colors = getColors(named: .white, color2: .secondary_1)
            let startPoint = UnitPoint(x: 0, y: 1)
            let endPoint = UnitPoint(x: 1, y: 0)
            
            return LinearGradient(colors: [colors.0, colors.1],
                                  startPoint: startPoint,
                                  endPoint: endPoint)
        }
    }
    
    // Colors
    static var primary_1: (Color, UIColor) {
        return (getColor(named: .primary_1), getUIColor(named: .primary_1))
    }
    static var primary_2: (Color, UIColor) {
        return (getColor(named: .primary_2), getUIColor(named: .primary_2))
    }
    static var secondary_1: (Color, UIColor) {
        return (getColor(named: .secondary_1), getUIColor(named: .secondary_1))
    }
    static var secondary_2: (Color, UIColor) {
        return (getColor(named: .secondary_2), getUIColor(named: .secondary_2))
    }
    static var black: (Color, UIColor) {
        return (getColor(named: .black), getUIColor(named: .black))
    }
    static var neutral_900: (Color, UIColor) {
        return (getColor(named: .neutral_900), getUIColor(named: .neutral_900))
    }
    static var neutral_800: (Color, UIColor) {
        return (getColor(named: .neutral_800), getUIColor(named: .neutral_800))
    }
    static var neutral_700: (Color, UIColor) {
        return (getColor(named: .neutral_700), getUIColor(named: .neutral_700))
    }
    static var neutral_600: (Color, UIColor) {
        return (getColor(named: .neutral_600), getUIColor(named: .neutral_600))
    }
    static var neutral_500: (Color, UIColor) {
        return (getColor(named: .neutral_500), getUIColor(named: .neutral_500))
    }
    static var neutral_400: (Color, UIColor) {
        return (getColor(named: .neutral_400), getUIColor(named: .neutral_400))
    }
    static var neutral_300: (Color, UIColor) {
        return (getColor(named: .neutral_300), getUIColor(named: .neutral_300))
    }
    static var neutral_200: (Color, UIColor) {
        return (getColor(named: .neutral_200), getUIColor(named: .neutral_200))
    }
    static var neutral_100: (Color, UIColor) {
        return (getColor(named: .neutral_100), getUIColor(named: .neutral_100))
    }
    static var white: (Color, UIColor) {
        return (getColor(named: .white), getUIColor(named: .white))
    }
    static var attention: (Color, UIColor) {
        return (getColor(named: .attention), getUIColor(named: .attention))
    }
    static var shadow_1: (Color, UIColor) {
        return (getColor(named: .shadow_1), getUIColor(named: .shadow_1))
    }
    
    // Permanent Colors (Don't change w/ environment attributes)
    static var text_black: (Color, UIColor) {
        return (getColor(named: .text_black), getUIColor(named: .text_black))
    }
    static var text_white: (Color, UIColor) {
        return (getColor(named: .text_white), getUIColor(named: .text_white))
    }
    static var icon_black: (Color, UIColor) {
        return (getColor(named: .icon_black), getUIColor(named: .icon_black))
    }
    static var icon_white: (Color, UIColor) {
        return (getColor(named: .icon_white), getUIColor(named: .icon_white))
    }

    // Gradients
    static var gradient_1: LinearGradient {
        return getLinearGradient(named: .gradient_1)
    }
    static var gradient_2: LinearGradient {
        return getLinearGradient(named: .gradient_2)
    }
}

// MARK: Colors Enum
enum IterableColors: String, CaseIterable, Codable, Hashable {
    case primary_1, primary_2, secondary_1, secondary_2, black, neutral_900, neutral_800, neutral_700, neutral_600, neutral_500, neutral_400, neutral_300, neutral_200, neutral_100, white, attention, shadow_1, text_black, text_white, icon_white, icon_black
}

// MARK: Gradients Enum
enum IterableGradients: String, CaseIterable, Codable, Hashable {
    case gradient_1, gradient_2
}
