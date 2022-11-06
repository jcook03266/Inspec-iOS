//
//  VerticalOnboardingCarouselView.swift
//  Inspec
//
//  Created by Justin Cook on 11/5/22.
//

import SwiftUI

struct VOC: View {
    @ObservedObject var model: VOCViewModel
    
    let progressBarLeadingPadding: CGFloat = 15
    
    var skipAction: (() -> Void) {
        return {
            
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
        let view = PartitionedProgressView(viewModel: model.progressBar)
        
        return view
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
    }
    
    /// CTA that completes the user's onboarding experience and shifts them to the login / create an account home screen
    var lastPageCTAButton: some View {
        VStack {
            RoundedRectangularCTA(action: {
                continueCTAButton()
            },
                                  message: "Let's GO!")
        }
    }
    
    var body: some View {
        ZStack {
            HStack {
                
            }
            
            HStack {
                VStack {
                    Spacer()
                    progressBar
                        .padding([.leading], progressBarLeadingPadding)
                    Spacer()
                }
                Spacer()
                
                if (!model.isOnLastPage) {
                    navigationButtons
                }
                else {
                    lastPageCTAButton
                }
            }
            
        }
    }
}

struct VOC_Previews: PreviewProvider {
    private static func getTestModel() -> VOCViewModel {
        let viewModel = VOCViewModel(id: 0)
        let pages = OnboardingPages(pageManager: viewModel).getAllPages()
        
        viewModel.addPages(pages: pages)
        
        return viewModel
    }
    
    static var previews: some View {
        VOC(model: getTestModel())
    }
}
