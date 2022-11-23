//
//  LaunchScreenBridgeView.swift
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
    @State var showAppName: Bool = false
    
    // MARK: - Styling
    var appIconShadowColor: Color {
        didAppear ? Colors.text_white.0 : .clear
    }
    var appIconShadowRadius: CGFloat {
        didAppear ? 30 : 0
    }
    
    var launchScreenImage: some View {
        model.launchScreenImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: model.launchScreenImageSize.width,
                   height: model.launchScreenImageSize.height)
            .shadow(color: appIconShadowColor,
                    radius: appIconShadowRadius)
    }
    
    var appNameTextView: some View {
        HStack {
            Spacer()
            
            if didAppear && showAppName {
                Text(model.appNameText)
                    .withFont(model.appNameTextFont)
                    .transition(
                        .offset(CGSize(width: 0,
                                       height: 400)))
                    .animation(
                        .spring()
                        .speed(1.2),
                        value: showAppName)
                    .foregroundColor(model.textColor)
            }
            
            Spacer()
        }
        .offset(CGSize(width: 0, height: 100))
    }
    
    var body: some View {
        GeometryReader { geom in
            VStack {
                launchScreenImage
                    .background(
                        ForEach(model.componentCircleViewModels, id: \.id) { model in
                            if didAppear {
                                LaunchScreenBridgeViewModel.ComponentCircle(model: model)
                            }
                        }
                    )
                
                appNameTextView
            }
            .onAppear {
                withAnimation(.spring(response: 0.75)) {
                    didAppear = true
                    showAppName = true
                }
                
                resetAnimation()
            }
            .frame(maxWidth: .infinity,
                   maxHeight: .infinity)
            .foregroundColor(model.foregroundColor)
            .background(model.backgroundGradient)
        }
    }
    
    private func resetAnimation() {
        DispatchQueue.main.asyncAfter(
            deadline: .now() + LaunchScreenManager.displayDuration - 0.5) {
                withAnimation(.spring(response: 1)) {
                    showAppName = false
                }
            }
    }
}

struct LaunchScreenBridgeView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenBridgeView()
    }
}
