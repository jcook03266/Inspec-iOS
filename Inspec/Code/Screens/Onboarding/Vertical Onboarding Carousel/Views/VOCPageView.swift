//
//  VOCPageView.swift
//  Inspec
//
//  Created by Justin Cook on 11/6/22.
//

import SwiftUI
import Lottie

struct VOCPageView: View {
    // Observed
    @StateObject var model: VOCPageViewModel
    /// Prevents deallocation when loading between pages w/ observedObject
    @StateObject var textSectionExpansionController: TextSectionExpansionController = TextSectionExpansionController(expanded: !DeviceConstants.isDeviceSmallFormFactor(), enableExpansion: DeviceConstants.isDeviceSmallFormFactor())
    @ObservedObject var manager: VOCViewModel
    
    // States
    @State var scrollEnabled: Bool = true

    let font: FontRepository = .heading_2,
        titleGradient: LinearGradient = Colors.gradient_1,
        textSectionBackgroundColor: SwiftUI.Color = Colors.white.0.opacity(0.75)
    
    var animationShouldPlay: Bool {
        return model.isCurrentPage
    }
    
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
            .frame(maxWidth: .infinity,
                   maxHeight: 100,
                   alignment: .leading)
    }
    
    var lottieAnimationView: some View {
        let lottieView = LottieViewUIViewRepresentable(animationName: model.lottieAnimation, shouldPlay: .constant(animationShouldPlay))
        
        return lottieView
            .frame(width: 300, height: 200)
        
    }
    
    var messageTextView: BorderedTextSection {
        return BorderedTextSection(backgroundColor: textSectionBackgroundColor,
                                   message: (nil, model.message),
                                   maxHeight: 150,
                                   expansionController: textSectionExpansionController)
    }
    
    var body: some View {
        GeometryReader { geom in
            ZStack {
                ScrollView {
                    VStack {
                        Group {
                            Group {
                                if model.isCurrentPage {
                                    Spacer()
                                    titleTextView
                                }
                            }
                            .transition(AnyTransition.slideForwards)
                                
                                lottieAnimationView
                                    .scaledToFit()
                                    .opacity(model.isCurrentPage ? 1 : 0)
                            
                            Group {
                                if model.isCurrentPage {
                                    HStack {
                                        messageTextView
                                    }
                                    Spacer()
                                    Spacer()
                                }
                            }
                            .transition(AnyTransition.slideBackwards)
                            
                        }
                        .animation(.spring(response: 1.2),
                                   value: model.isCurrentPage)
                    }
                    .frame(width: geom.size.width,
                           height: geom.size.height)
                    .animation(.spring(),
                               value: textSectionExpansionController.expanded)
                }
                .scrollDisabled(!scrollEnabled)
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
        
        VOCPageView(model: model,
                    manager: model.manager)
    }
}
