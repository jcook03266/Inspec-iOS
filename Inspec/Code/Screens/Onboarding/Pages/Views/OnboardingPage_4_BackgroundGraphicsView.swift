//
//  OnboardingPage_4_BackgroundGraphicsView.swift
//  Inspec
//
//  Created by Justin Cook on 11/8/22.
//

import SwiftUI

struct OBP_4_BackgroundGraphicsView: View {
    let graphicsScaler = OBGraphicsScaler(idealImageSize: CGSize(width: 100, height: 100),
                                          idealImageOffset: CGPoint(x: 6, y: 0))
    
    var twoToneDotMatrices: Image {
        return Images.getImage(named: .two_tone_dotMatrices)
    }
    
    var body: some View {
        VStack {
            HStack {
                twoToneDotMatrices
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: graphicsScaler.realImageSize.width,
                           height: graphicsScaler.realImageSize.height)
                    .offset(x: graphicsScaler.realImageOffset.x,
                            y: graphicsScaler.realImageOffset.y)
                
                Spacer()
            }
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct OBP_4_BackgroundGraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        OBP_4_BackgroundGraphicsView()
    }
}
