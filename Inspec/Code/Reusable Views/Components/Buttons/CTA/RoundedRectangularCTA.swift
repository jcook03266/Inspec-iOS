//
//  RoundedRectangularCTA.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

struct RoundedRectangularCTA: View {
    var action: (() -> Void)
    var backgroundColor: Color = Colors.primary_1.0,
        foregroundColor: Color = Colors.text_white.0,
        shadowColor: Color = Colors.shadow_1.0,
        font: FontRepository = .body_S_Bold,
        size: CGSize = CGSize(width: 350, height: 60),
        padding: CGFloat = 0,
        message: String = "Let's Go!"
    
    let cornerRadius: CGFloat = 40,
        shadowCoordinates: CGPoint = CGPoint(x: 0, y: 2),
        shadowRadius: CGFloat = 2
    
    var body: some View {
        Button(action: {
            HapticFeedbackDispatcher.interstitialCTAButtonPress()
            action()
        }) {
            Text(message)
                .frame(width: size.width, height: size.height)
                .withFont(font)
                .padding([.all], padding)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .clipShape(Capsule())
                .shadow(color: shadowColor,
                        radius: shadowRadius,
                        x: shadowCoordinates.x,
                        y: shadowCoordinates.y)
        }
        .buttonStyle(GenericSpringyShrink())
    }
}

struct RoundedRectangularCTA_Previews: PreviewProvider {
    static var previews: some View {
        RoundedRectangularCTA(action: {})
    }
}
