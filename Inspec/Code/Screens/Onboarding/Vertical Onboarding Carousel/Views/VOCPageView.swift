//
//  VOCPageView.swift
//  Inspec
//
//  Created by Justin Cook on 11/6/22.
//

import SwiftUI
import Lottie

struct VOCPageView: View {
    @StateObject var model: VOCPageViewModel
    /// Prevents deallocation when loading between pages w/ observedObject
    @StateObject var textSectionExpansionController: TextSectionExpansionController = TextSectionExpansionController(expanded: !DeviceConstants.isDeviceSmallFormFactor())
    
    let font: FontRepository = .heading_2,
        titleGradient: LinearGradient = Colors.gradient_1
    
    var titleTextView: some View {
        return Text(model.title)
            .withFont(font)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .overlay(titleGradient)
            .mask(
                Text(model.title)
                    .withFont(font)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .minimumScaleFactor(0.1)
            )
            .frame(maxWidth: .infinity, maxHeight: 100, alignment: .leading)
    }
    
    var lottieAnimationView: some View {
        let lottieView = LottieView(animationName: model.lottieAnimation)
        
        return lottieView
            .frame(width: 300, height: 200)
        
    }
    
    var messageTextView: BorderedTextSection {
        return BorderedTextSection(message: (nil, model.message), maxHeight: 150, expansionController: textSectionExpansionController)
    }
    
    var body: some View {
        ZStack {
            model.backgroundGraphics
            
            GeometryReader { geom in
            ScrollView {
                    VStack {
                        Spacer()
                        titleTextView
                        
                        
                        lottieAnimationView
                            .scaledToFit()
                        
                        HStack {
                            messageTextView
                        }
                        Spacer()
                        Spacer()
                    }
                    .frame(width: geom.size.width, height: geom.size.height)
                    .animation(.spring(),
                               value: textSectionExpansionController.expanded)
                }
            }
        }
    }
}

struct VOCPageView_Previews: PreviewProvider {
    private static func getTestModel() -> VOCPageViewModel {
        let model = OnboardingPages(pageManager: .init(id: 0)).getAllPages()[0]
        
        return model
    }
    
    static var previews: some View {
        let model = getTestModel()
        
        VOCPageView(model: model)
    }
}
