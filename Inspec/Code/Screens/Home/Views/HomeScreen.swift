//
//  HomeScreen.swift
//  Inspec
//
//  Created by Justin Cook on 11/18/22.
//

import SwiftUI

struct HomeScreen: View {
    // MARK: - Environment
    // Listen for scene changes, i.e when the app leaves the foreground
    @Environment(\.scenePhase) var scenePhase
    
    // MARK: - Observed
    @StateObject var model: HomeScreenViewModel
    @StateObject var textOscillator: TextOscillator
    
    // MARK: - Background
    var backgroundVideo: some View {
        LoopingVideoPlayerUIViewRepresentable(lvpPlaybackCoordinator: model.videoPlaybackCoordinator)
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
            .lineLimit(2)
            .padding([.leading],
                     titleLeadingPadding)
            .padding([.bottom], titleBottomPadding)
            .minimumScaleFactor(0.5)
            .applyGradient(gradient: model.titleGradient)
    }
    
    var subtitle: some View {
        Text(textOscillator.currentValueAsLocalizedStringKey)
            .withFont(model.titleFont)
            .multilineTextAlignment(.leading)
            .lineLimit(1)
            .padding([.leading],
                     titleLeadingPadding)
            .padding([.bottom], titleBottomPadding)
            .minimumScaleFactor(0.5)
            .applyGradient(gradient: model.titleGradient)
            .id("subtitle" + textOscillator.currentValue)
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
            model.continueAsAGuestAction()
        }) {
            HStack(alignment: .center) {
                Text(model.continueAsGuestText)
                    .withFont(model.continueAsGuestFont)
                    .fontWeight(.semibold)
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
        .buttonStyle(OffsettableShrinkButtonStyle(offset: CGSize(width: -10, height: 0)))
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
                .buttonStyle(OffsettableShrinkButtonStyle())
                
                Spacer()
            }
            
            // Register Button
            HStack {
                HalfRoundedRectangularCTA(action: model.loginAction,
                                          backgroundColor: model.registerButtonBackgroundColor,
                                          foregroundColor: model.registerButtonForegroundColor,
                                          font: model.loginButtonFont,
                                          size: CGSize(width: 370, height: 50),
                                          message: (nil,
                                                    model.registerButtonText))
                .buttonStyle(OffsettableShrinkButtonStyle(offset: CGSize(width: -30, height: 0)))
                
             Spacer()
            }
        }
    }
    
    // MARK: Padding + Dimensions
    var titleLeadingPadding: CGFloat = 15,
        titleBottomPadding: CGFloat = 5,
        characterPortraitTrailingPadding: CGFloat = 15,
        continueAsGuestButtonLeadingPadding: CGFloat = 15,
        continueAsGuestButtonTopPadding: CGFloat = 10,
        continueAsGuestButtonBottomPadding: CGFloat = 60,
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
                            VStack(alignment: .leading) {
                                title
                                subtitle
                                    .transition(.slideBackwards.animation(.spring()))
                            }
                            
                            Spacer()
                            
                            IanCharacterPortrait
                        }
                        .transition(.slideForwards.animation(.spring(response: 1)))
                        
                        Spacer()
                        
                        signUpLoginButtons
                            .transition(.slideForwards.animation(.spring(response: 1.25)))
                              
                        
                        continueAsGuestButton
                            .transition(.slideBackwards.animation(.spring(response: 1)))
                }
                    }
                .animation(.spring(response: 0.8), value: textOscillator.currentValue)
                .animation(.spring(response: 1), value: didAppear)
                    .frame(minHeight: geom.size.height)
                }
            }
        }
        .background(
            ZStack {
                backgroundVideo
                
                backgroundEffects
            }
                .ignoresSafeArea()
        )
        .onAppear {
            didAppear = true
            model.videoPlaybackCoordinator.start()
            textOscillator.startOscillating()
        }
        .onChange(of: scenePhase) { scene in
            if scene == .active {
                // Resume playback if the app re-enters the foreground
                model.videoPlaybackCoordinator.start()
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static func getModel() -> HomeScreenViewModel {
        return .init(coordinator: .init())
    }
    
    static func getTextOscillator() -> TextOscillator {
        let model = getModel()
        let oscillator = TextOscillator(initialValue: model.initialSubtitleString)
        oscillator.stringsToCycleThrough = model.localizedStringArray
        
        return oscillator
    }
    
    static var previews: some View {
        HomeScreen(model: .init(coordinator: .init()),
                   textOscillator: getTextOscillator())
    }
}
