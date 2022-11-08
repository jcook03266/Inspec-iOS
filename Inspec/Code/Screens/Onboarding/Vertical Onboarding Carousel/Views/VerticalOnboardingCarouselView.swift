//
//  VerticalOnboardingCarouselView.swift
//  Inspec
//
//  Created by Justin Cook on 11/5/22.
//

import SwiftUI

struct VOC: View {
    @StateObject var model: VOCViewModel
    @StateObject var progressBarModel: PartitionedProgressBarViewModel
    
    let progressBarLeadingPadding: CGFloat = 15,
        pageTrailingPadding: CGFloat = 12,
    /// The amount of space roughly taken up by the progress bar and its safe area
        progressBarSafeAreaWidth: CGFloat = 50,
        navigationButtonsTrailingPadding: CGFloat = 15,
        bottomNavigationButtonPadding: CGFloat = 10
    
    /// Screen width minus this equals the ideal page width needed to view the content as intended
    var pageEdgeOffset: CGFloat {
        return progressBarSafeAreaWidth + pageTrailingPadding
    }
    /// Used for calculating the current offset of the grid relative to the progress bar's progress
    var zeroIndexedCurrentPage: (Int, CGFloat) {
        let zeroIndex = model.currentPage - 1
        return (zeroIndex, CGFloat(zeroIndex))
    }
    
    var skipAction: (() -> Void) {
        return {
            self.model.skipForward()
        }
    }
    var upArrowAction: (() -> Void) {
        return {
            self.model.goBackward()
        }
    }
    var downArrowAction: (() -> Void) {
        return {
            self.model.goForward()
        }
    }
    var continueCTAButton: (() -> Void) {
        return {
            
        }
    }
    
    var progressBar: PartitionedProgressView {
        let view = PartitionedProgressView(viewModel: progressBarModel)
        
        return view
    }
    
    /// To skip through the onboarding
    var skipButton: some View {
        HStack {
            Text(LocalizedStrings.getLocalizedStringKey(for: .NAVIGATION_BUTTON_SKIP))
                .foregroundColor(Colors.secondary_1.0)
                .withFont(.body_L)
                .fontWeight(.semibold)
            
            ArrowButton(action: {
                skipAction()
            },
                        arrowDirection: .down,
                        buttonType: .skip2,
                        isEnabled: .constant(!self.model.isOnLastPage))
        }
    }
    
    /// Goes backwards from the last page
    var lastPageBackButton: some View {
        ArrowButton(action: {
            upArrowAction()
        },
                    arrowDirection: .up,
                    buttonType: .next,
                    isEnabled: .constant(self.model.isOnLastPage))
    }
    
    /// Buttons used to navigate through the onboarding screen before the last page is displayed
    var navigationButtons: some View {
        VStack(spacing: 20) {
            //Up Arrow
            ArrowButton(action: {
                upArrowAction()
            },
                        arrowDirection: .up,
                        buttonType: .next,
                        isEnabled: .constant(!self.model.isOnFirstPage))
            
            //Down Arrow
            ArrowButton(action: {
                downArrowAction()
            },
                        arrowDirection: .down,
                        buttonType: .next,
                        isEnabled: .constant(!self.model.isOnLastPage))
        }
        .padding([.bottom], bottomNavigationButtonPadding)
    }
    
    /// CTA that completes the user's onboarding experience and shifts them to the login / create an account home screen
    var lastPageCTAButton: some View {
        VStack {
            RoundedRectangularCTA(action: {
                continueCTAButton()
            }, message: (nil, LocalizedStrings.getLocalizedStringKey(for: .ONBOARDING_PAGE_4_CTA)))
        }
        .padding([.bottom], bottomNavigationButtonPadding)
    }
    
    var pageViews: some View {
        GeometryReader { geom in
                    LazyVGrid(columns: OnboardingPages.gridItemLayout) {
                        
                        ForEach(model.pages, id: \.pageNumber) { pageModel in
                            
                            let page = VOCPageView(model: pageModel)
                            
                            ZStack {
                                pageModel.backgroundGraphics
                                HStack {
                                    Spacer()
                                    VStack{
                                        page
                                            .frame(width: geom.size.width - pageEdgeOffset,
                                                   height: geom.size.height)
                                            .padding([.trailing], pageTrailingPadding)
                                    }
                                }
                            }
                        }
                    }
                    .offset(CGSize(width: 0, height: -(geom.size.height * zeroIndexedCurrentPage.1)))
                    .animation(.spring(response: 1), value: model.currentPage)
        }
        .ignoresSafeArea()
    }
    
    var body: some View {
        GeometryReader { geom in
            ZStack {
                pageViews
                
                HStack {
                    VStack {
                        Spacer()
                        progressBar
                            .padding([.leading], progressBarLeadingPadding)
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    Spacer()
                    
                    if (!model.isOnLastPage) {
                        VStack {
                            HStack {
                                Spacer()
                                skipButton
                            }
                            
                            Spacer()
                            
                            HStack {
                                Spacer()
                                navigationButtons
                            }
                        }
                        .padding([.trailing],
                                 navigationButtonsTrailingPadding)
                    }
                    else {
                        VStack(alignment: .center) {
                            HStack {
                                Spacer()
                                lastPageBackButton
                            }
                            .padding([.trailing],
                                     navigationButtonsTrailingPadding)
                            Spacer()
                        }
                    }
                }
                
                if (model.isOnLastPage) {
                    VStack {
                        Spacer()
                        lastPageCTAButton
                    }
                }
            }
        }
    }
}

struct VOC_Previews: PreviewProvider {
    private static func getTestModel() -> VOCViewModel {
        let viewModel = VOCViewModel(id: 0)
        
        return viewModel
    }
    
    static var previews: some View {
        let model = getTestModel()
        
        VOC(model: model,
            progressBarModel: model.progressBar)
    }
}
