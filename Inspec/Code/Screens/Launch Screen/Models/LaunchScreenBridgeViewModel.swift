//
//  LaunchScreenBridgeViewModel.swift
//  Inspec
//
//  Created by Justin Cook on 11/22/22.
//

import SwiftUI

class LaunchScreenBridgeViewModel: ObservableObject {
    // MARK: - Assets
    var launchScreenImage: Image = Images.getImage(named: .Ian_Portrait_White_Border_512px)
    
    // MARK: Styling
    // Color
    var backgroundColor: Color = Colors.getColor(named: .primary_1)
    var foregroundColor: Color = Colors.getColor(named: .text_white)
    // Font
    var appNameTextFont: FontRepository = .heading_1
    
    // MARK: - Localized Text
    var appNameText: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .APP_NAME)
    
    // MARK: - Dimensions
    var launchScreenImageSize: CGSize = CGSize(width: 290, height: 244)
    
    init() {}
}
