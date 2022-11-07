//
//  VOCPageView.swift
//  Inspec
//
//  Created by Justin Cook on 11/6/22.
//

import SwiftUI

struct VOCPageView: View {
    @StateObject var model: VOCPageViewModel
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
                    .minimumScaleFactor(0.5)
            )
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var lottieAnimationView: some View {
        return Images.getImage(named: .apple)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
    }
    
    var messageTextView: BorderedTextSection {
        return BorderedTextSection(message: (nil, model.message))
    }
    
    var body: some View {
        ZStack {
            model.backgroundGraphics
            
            VStack {
                titleTextView
                
                lottieAnimationView
                
                HStack {
                    messageTextView
                }
            }
        }
    }
}

struct VOCPageView_Previews: PreviewProvider {
    private static func getTestModel() -> VOCPageViewModel {
        let model = OnboardingPages(pageManager: .init(id: 0)).getAllPages()[1]
        
        return model
    }
    
    static var previews: some View {
        let model = getTestModel()
        
        VOCPageView(model: model)
    }
}
