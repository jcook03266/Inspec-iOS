//
//  ButtonStyles.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

struct GenericSpringyShrink: ButtonStyle {
    var springResponse: CGFloat = 1.2
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.75 : 1)
            .scaleEffect(configuration.isPressed ? 0.8 : 1)
            .animation(.spring(response: 1.2), value: configuration.isPressed)
    }
}
