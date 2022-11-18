//
//  HomeScreen.swift
//  Inspec
//
//  Created by Justin Cook on 11/18/22.
//

import SwiftUI

struct HomeScreen: View {
    // MARK: - Observed
    @StateObject var model: HomeScreenViewModel
    
    // MARK: - Background
    var backgroundImage: some View {
        model.backgroundImage
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
    
    var backgroundEffects: some View {
        Rectangle()
            .foregroundColor(model.backgroundTintColor)
    }
    
    // MARK: Foreground
    var title: some View {
        Text(model.title)
            .withFont(model.titleFont)
            .multilineTextAlignment(.leading)
            .frame(width: 270)
            .padding([.bottom])
            .padding([.leading],
                     titleLeadingPadding)
            .minimumScaleFactor(0.5)
            .applyGradient(gradient: model.titleGradient)
    }
    
    var IanCharacterPortrait: some View {
        model.characterPortraitImage
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 90, height: 130)
            .padding([.trailing], characterPortraitTrailingPadding)
            .scaledToFit()
    }

    var ghostIcon: some View {
        model.continueAsGuestIcon
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 24, height: 24)
            .scaledToFit()
    }
    
    var continueAsGuestButton: some View {
        Button(action: {
            HapticFeedbackDispatcher.interstitialCTAButtonPress()
            
            model.continueAsAGuestAction()
        }) {
            HStack(alignment: .center) {
                Text(model.continueAsGuestText)
                    .withFont(model.continueAsGuestFont)
                    .foregroundColor(model.continueAsGuestForegroundColor)
                    .lineLimit(1)

                ghostIcon
                
                Spacer()
            }
            .padding([.leading],
                     continueAsGuestButtonLeadingPadding)
            .padding([.top],
                     continueAsGuestButtonTopPadding)
            .padding([.bottom],
                     continueAsGuestButtonBottomPadding)
        }
        .buttonStyle(GenericSpringyShrink())
    }
    
    var signUpLoginButtons: some View {
        VStack(spacing: loginSignUpButtonSpacing) {
            // Login Button
            HStack {
                HalfRoundedRectangularCTA(action: model.loginAction,
                                          backgroundColor: model.loginButtonBackgroundColor,
                                          foregroundColor: model.loginButtonForegroundColor,
                                          font: model.loginButtonFont,
                                          size: CGSize(width: 280, height: 50),
                                          message: (nil,
                                                    model.loginButtonText))
                Spacer()
            }
            .transition(.scale)
            
            // Register Button
            HStack {
                HalfRoundedRectangularCTA(action: model.loginAction,
                                          backgroundColor: model.registerButtonBackgroundColor,
                                          foregroundColor: model.registerButtonForegroundColor,
                                          font: model.loginButtonFont,
                                          size: CGSize(width: 370, height: 50),
                                          message: (nil,
                                                    model.registerButtonText))
                .transition(.slide)
             Spacer()
            }
        }
    }
    
    // MARK: Padding + Dimensions
    var titleLeadingPadding: CGFloat = 15,
        characterPortraitTrailingPadding: CGFloat = 15,
        continueAsGuestButtonLeadingPadding: CGFloat = 15,
        continueAsGuestButtonTopPadding: CGFloat = 10,
        continueAsGuestButtonBottomPadding: CGFloat = 30,
        loginSignUpButtonSpacing: CGFloat = 20
    
    // MARK: - States
    @State var didAppear: Bool = false
    
    var body: some View {
        GeometryReader { geom in
        ZStack {
            ScrollView(.vertical,
                       showsIndicators: false) {
                
                VStack {
                    if didAppear {
                        HStack {
                            title
                                .transition(.slideBackwards.animation(.spring(response: 1)))
                            
                            Spacer()
                            
                            IanCharacterPortrait
                                .transition(.scale.animation(.spring(response: 1)))
                        }
                        
                        Spacer()
                        
                        signUpLoginButtons
                              
                        
                        continueAsGuestButton
                }
                    }
                .animation(.spring(response: 1.5), value: didAppear)
                    .frame(minHeight: geom.size.height)
                }
            }
        }
        .background(
            ZStack {
                backgroundImage
                
                backgroundEffects
            }
                .ignoresSafeArea()
        )
        .onAppear {
            withAnimation(.spring(response: 1.5)){
                didAppear.toggle()
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(model: .init(coordinator: .init()))
    }
}
