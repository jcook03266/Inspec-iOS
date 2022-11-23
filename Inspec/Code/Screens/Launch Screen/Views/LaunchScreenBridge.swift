//
//  LaunchScreenBridge.swift
//  Inspec
//
//  Created by Justin Cook on 11/22/22.
//

import SwiftUI

/// View displayed after the launch screen, used as a stylized splash screen to compliment UX
struct LaunchScreenBridgeView: View {
    // MARK: - Observed
    @StateObject var model: LaunchScreenBridgeViewModel = .init()
    
    // MARK: - States
    @State var didAppear: Bool = false
    
    var launchScreenImage: some View {
        model.launchScreenImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: model.launchScreenImageSize.width,
                   height: model.launchScreenImageSize.height)
    }
    
    var appNameTextView: some View {
        HStack {
            Spacer()
            
            if didAppear {
                Text(model.appNameText)
                    .withFont(model.appNameTextFont)
                    .transition(.scale)
                    .animation(.spring(), value: didAppear)
            }
                
            Spacer()
        }
    }
    
    var body: some View {
        VStack {
            launchScreenImage
            
            appNameTextView
        }
        .onAppear {
            withAnimation(.spring(response: 1)) {
                didAppear = true
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .foregroundColor(model.foregroundColor)
        .background(model.backgroundColor)
    }
}

struct LaunchScreenBridge_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenBridgeView()
    }
}
