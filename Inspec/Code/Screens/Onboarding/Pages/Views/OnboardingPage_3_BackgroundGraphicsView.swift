//
//  OnboardingPage_3_BackgroundGraphicsView.swift
//  Inspec
//
//  Created by Justin Cook on 11/8/22.
//

import SwiftUI

struct OBP_3_BackgroundGraphicsView: View {
    let graphicsScaler = OBGraphicsScaler(idealImageSize: CGSize(width: 150, height: 150),
                                          idealImageOffset: CGPoint(x: 0, y: -24))
    
    var goldenRatioIanPorthole: Image {
        return Images.getImage(named: .golden_ratio_IanPorthole)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                goldenRatioIanPorthole
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: graphicsScaler.realImageSize.width,
                           height: graphicsScaler.realImageSize.height)
                    .offset(x: graphicsScaler.realImageOffset.x,
                            y: graphicsScaler.realImageOffset.y)
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

struct OBP_3_BackgroundGraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        OBP_3_BackgroundGraphicsView()
    }
}
