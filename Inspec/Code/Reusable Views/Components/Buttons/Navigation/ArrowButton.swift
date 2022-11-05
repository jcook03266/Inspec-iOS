//
//  ArrowButton.swift
//  Inspec
//
//  Created by Justin Cook on 11/4/22.
//

import SwiftUI

struct ArrowButton: View {
    var action: (() -> Void)
    var backgroundColor: Color = Colors.white.0,
        foregroundColor: Color = Colors.primary_1.0,
        shadowColor: Color = Colors.shadow_1.0,
        font: FontRepository = .body_S_Bold,
        size: CGSize = CGSize(width: 60, height: 60),
        imageSize: CGSize = CGSize(width: 24, height: 24),
        padding: CGFloat = 0,
        arrowDirection: ArrowDirection,
        buttonType: ButtonType
        
        
    @State var isEnabled: Bool = true
        
    var arrowIcon: Image {
        switch buttonType {
        case .skip:
            switch arrowDirection {
            case .up:
                return Icons.getIconImage(named: .chevron_up)
            case .down:
                return Icons.getIconImage(named: .chevron_down)
            case .left:
                return Icons.getIconImage(named: .chevron_left)
            case .right:
                return Icons.getIconImage(named: .chevron_right)
            }
        case .skip2:
            switch arrowDirection {
            case .up, .down, .left:
                return Icons.getIconImage(named: .chevron_left_2)
            case .right:
                return Icons.getIconImage(named: .chevron_right_2)
            }
        case .next:
            switch arrowDirection {
            case .up:
                return Icons.getIconImage(named: .arrow_up)
            case .down:
                return Icons.getIconImage(named: .arrow_down)
            case .left:
                return Icons.getIconImage(named: .arrow_left)
            case .right:
                return Icons.getIconImage(named: .arrow_right)
            }
        }
    }
    
    let cornerRadius: CGFloat = 40,
        shadowCoordinates: CGPoint = CGPoint(x: 0, y: 4),
        shadowRadius: CGFloat = 4,
        disabledForegroundColor: Color = Colors.neutral_500.0
    
    var body: some View {
        Button(action: {
            HapticFeedbackDispatcher.arrowButtonPress()
            action()
        }) {
            ZStack {
                Circle()
                    .frame(width: size.width, height: size.height)
                    .foregroundColor(backgroundColor)
                    .shadow(color: shadowColor,
                            radius: shadowRadius,
                            x: shadowCoordinates.x,
                            y: shadowCoordinates.y)
                    .overlay(
                        arrowIcon
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: imageSize.width, height: imageSize.height)
                            .padding([.all], padding)
                            .foregroundColor(isEnabled ? foregroundColor : disabledForegroundColor)
                    )
            }
            .rotationEffect(
                .degrees( (buttonType == .skip2) ? (arrowDirection == .up ? 90 : -90) : 0)
            )
        }
        .disabled(!isEnabled)
        .buttonStyle(GenericSpringyShrink())
    }
    
    enum ArrowDirection: String, CaseIterable {
        case up,
        down,
        left,
        right
    }
    
    enum ButtonType: String, CaseIterable {
        case skip,
             skip2,
             next
    }
}

struct ArrowButton_Previews: PreviewProvider {
    static var previews: some View {
        ArrowButton(action: {},
                    arrowDirection: .down,
                    buttonType: .skip2,
                    isEnabled: true)
    }
}
