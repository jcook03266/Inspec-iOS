//
//  LoginScreen.swift
//  Inspec
//
//  Created by Justin Cook on 11/26/22.
//

import SwiftUI

struct LoginScreen: View {
    // MARK: - Observed
    @StateObject var model: LoginScreenViewModel
    
    // MARK: - States
    @State private var dashedCirclePhase: CGFloat = 0 /// Animatable
    
    // MARK: - Dimensions
    // Corner Radius
    var formSectionCornerRadius: CGFloat = 60,
        // Padding
        textFieldSpacing: CGFloat = 20,
        textFieldSidePadding: CGFloat = 15,
        textFieldTopPadding: CGFloat = 25,
        titleLeadingPadding: CGFloat = 20,
        titleTopPadding: CGFloat = 20,
        formSectionBottomPadding: CGFloat = 65,
        passwordResetButtonLeadingPadding: CGFloat = 20,
        passwordResetButtonTopPadding: CGFloat = 15,
        signInButtonTopPadding: CGFloat = 20,
        signUpButtonTopPadding: CGFloat = 5,
        accountCreationPromptLeadingPadding: CGFloat = 5,
        accountCreationPromptTopPadding: CGFloat = 40,
        thirdPartySignInDividerTopPadding: CGFloat = 25,
        thirdPartyButtonSpacing: CGFloat = 80,
        thirdPartyButtonTopPadding: CGFloat = 20,
        // Sizes
        dashedCircleSize: CGSize = CGSize(width: 200,
                                          height: 200),
        signInButtonSize: CGSize = CGSize(width: 200,
                                          height: 60)
    
    
    // MARK: - Styling
    var formShadowRadius: CGFloat = 1,
        formShadowOffset: CGSize = CGSize(width: 0,
                                          height: 4)
    
    // MARK: - Subviews
    // Buttons
    var signInButton: some View {
        HStack {
            Spacer()
            HalfRoundedRectangularCTA(action: model.signInAction,
                                      backgroundColor: model.signInButtonBackgroundColor,
                                      foregroundColor: model.signInButtonTextColor,
                                      font: model.signInButtonTextFont,
                                      size: signInButtonSize,
                                      message: (nil, model.signInButtonText),
                                      anchor: .trailing)
            .fontWeight(.semibold)
            .buttonStyle(OffsettableButtonStyle(offset: CGSize(width: 20,
                                                               height: 0)))
            .padding([.top], signInButtonTopPadding)
        }
    }
    var signUpButton: some View {
        HStack {
            HalfRoundedRectangularCTA(action: model.signUpAction,
                                      backgroundColor: model.signUpButtonBackgroundColor,
                                      foregroundColor: model.signUpButtonTextColor,
                                      font: model.signInButtonTextFont,
                                      size: signInButtonSize,
                                      message: (nil, model.signUpButtonText))
            .fontWeight(.semibold)
            .buttonStyle(.offsettableButtonStyle)
            .padding([.top], signUpButtonTopPadding)
            
            Spacer()
        }
    }
    var passwordResetButton: some View {
        HStack {
            Button {
                HapticFeedbackDispatcher.genericButtonPress()
                model.resetPasswordAction()
            } label: {
                Text(model.forgotPasswordButtonText)
                    .withFont(model.passwordResetButtonTextFont)
                    .foregroundColor(model.passwordResetTextColor)
            }
            Spacer()
        }
        .buttonStyle(.genericSpringyShrink)
        .padding([.leading], passwordResetButtonLeadingPadding)
        .padding([.top], passwordResetButtonTopPadding)
    }
    var backButton: some View {
        HStack {
            ArrowButton(action: {
                HapticFeedbackDispatcher.genericButtonPress()
                
                model.backButtonAction()
            }, arrowDirection: .left,
                        buttonType: .skip,
                        isEnabled: .constant(true))
            
            Text(model.backButtonText)
                .withFont(model.backButtonTextFont)
                .foregroundColor(model.backButtonTextColor)
                .fontWeight(.semibold)
                .onTapGesture {
                    HapticFeedbackDispatcher.genericButtonPress()
                    model.backButtonAction()
                }
            
            Spacer()
        }
        .padding([.leading], titleLeadingPadding)
    }
    var twitterSignInButton: some View {
        Button {
            HapticFeedbackDispatcher.genericButtonPress()
            
            model.twitterSignInAction()
        } label: {
            IconView_Circle_Fill(iconImage: model.twitterLogo,
                                 iconColor: Colors.icon_black.0,
                                 backgroundColor: Colors.icon_white.0,
                                 iconSize: CGSize(width: 30,
                                                  height: 30),
                                 backgroundSize: CGSize(width: 60,
                                                        height: 60))
        }
        .buttonStyle(.genericSpringyShrink)
    }
    var googleSignInButton: some View {
        Button {
            HapticFeedbackDispatcher.genericButtonPress()
            
            model.googleSignInAction()
        } label: {
            IconView_Circle_Fill(iconImage: model.googleLogo,
                                 iconColor: Colors.icon_black.0,
                                 backgroundColor: Colors.icon_white.0,
                                 iconSize: CGSize(width: 30,
                                                  height: 30),
                                 backgroundSize: CGSize(width: 60,
                                                        height: 60))
        }
        .buttonStyle(.genericSpringyShrink)
    }
    var appleSignInButton: some View {
        Button {
            HapticFeedbackDispatcher.genericButtonPress()
            
            model.appleSignInAction()
        } label: {
            IconView_Circle_Fill(iconImage: model.appleLogo,
                                 iconColor: Colors.icon_black.0,
                                 backgroundColor: Colors.icon_white.0,
                                 iconSize: CGSize(width: 30,
                                                  height: 30),
                                 backgroundSize: CGSize(width: 60,
                                                        height: 60))
        }
        .buttonStyle(.genericSpringyShrink)
    }
    var thirdPartySignInButtons: some View {
        HStack(alignment: .center,
               spacing: thirdPartyButtonSpacing) {
            Spacer()
            
            twitterSignInButton
            
            googleSignInButton
            
            appleSignInButton
            
            Spacer()
        }
               .padding([.top], thirdPartyButtonTopPadding)
    }
    // TextFields
    var username_EmailTextField: some View {
        var textField =  SheathedTextField(model: model.username_emailTextFieldModel)
        
        textField.mainSize = CGSize(width: textField.mainSize.width - textFieldSidePadding * 2,
                                    height: textField.mainSize.height)
        
        return textField
    }
    var password_TextField: some View {
        var textField = SheathedTextField(model: model.passwordTextFieldModel)
        
        textField.mainSize = CGSize(width: textField.mainSize.width - textFieldSidePadding * 2,
                                    height: textField.mainSize.height)
        
        return textField
    }
    var textFields: some View {
        VStack(spacing: textFieldSpacing) {
            username_EmailTextField
            
            password_TextField
        }
    }
    // Text
    var titleTextView: some View {
        HStack {
            Text(model.titleText)
                .applyGradient(gradient: model.titleGradient)
                .withFont(model.titleFont)
                .fontWeight(.semibold)
                .padding([.leading], titleLeadingPadding)
            Spacer()
        }
        .padding([.top], titleTopPadding)
    }
    var signUpPrompt: some View {
        HStack {
            Text(model.accountCreationPromptText)
                .foregroundColor(model.signUpPromptTextColor)
                .withFont(model.signUpPromptTextFont)
                .padding([.leading], accountCreationPromptLeadingPadding)
                .padding([.top],
                         accountCreationPromptTopPadding)
            Spacer()
        }
    }
    var thirdPartySignInPrompt: some View {
        Text(model.thirdPartySignInPromptText)
            .foregroundColor(model.thirdPartySignInPromptTextColor)
            .withFont(model.thirdPartySignInPromptTextFont)
            .multilineTextAlignment(.center)
            .lineLimit(1)
    }
    // Section Divider
    var divider: some View {
        StraightSolidDividingLine(color: Colors.text_white.0,
                                  width: 115,
                                  height: 2)
    }
    var thirdPartySignInDivider: some View {
        HStack {
            Spacer()
            divider
       
            thirdPartySignInPrompt
            
            divider
            Spacer()
        }
        .padding([.top], thirdPartySignInDividerTopPadding)
        
    }
    // Background Graphics
    var dashedCircle: some View {
        Circle()
            .stroke(style: .init(lineWidth: 5,
                                 lineCap: .round,
                                 lineJoin: .bevel,
                                 dash: [10],
                                 dashPhase: dashedCirclePhase))
            .frame(width: dashedCircleSize.height, height: dashedCircleSize.height)
            .foregroundColor(model.backgroundDashedCircleTintColor)
    }
    
    var body: some View {
        GeometryReader { geom in
            ScrollView {
                VStack {
                    backButton
                    
                    titleTextView
                    
                    textFields
                    
                    passwordResetButton
                    
                    signInButton
                }
                .padding([.bottom], formSectionBottomPadding)
                .background(model.formSectionBackgroundColor, ignoresSafeAreaEdges: .all)
                .scaledToFit()
                .cornerRadius(formSectionCornerRadius, corners: [.bottomLeft])
                .background(
                    // Extension of the form's background color
                    Rectangle()
                        .frame(minHeight: geom.size.height)
                        .offset(y: -geom.size.height/2)
                        .foregroundColor(model.formSectionBackgroundColor)
                )
                .shadow(color: model.formShadowColor,
                        radius: formShadowRadius,
                        x: formShadowOffset.width,
                        y: formShadowOffset.height)
                .overlay(
                    dashedCircle
                        .position(x: geom.size.width - dashedCircleSize.width / 10,
                                  y: -dashedCircleSize.height/5)
                )
                .frame(width: geom.size.width)

                VStack(alignment: .center) {
                        signUpPrompt
                        
                        signUpButton
                        
                        thirdPartySignInDivider
                        
                        thirdPartySignInButtons
                    }
                .frame(width: geom.size.width)
            }
            .frame(width: geom.size.width)
        }
        .background(model.backgroundGradient)
        .submitScope(true) // Note: Prevents submissions from this page from backtracking and triggering other submissions from separate views in the hierarchy
        .onAppear {
            startAntMarchAnimation()
        }
    }
    
    func startAntMarchAnimation() {
        withAnimation(.linear
            .repeatForever(autoreverses: false)) {
                dashedCirclePhase -= 20
            }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen(model: .init(coordinator: .init()))
    }
}
