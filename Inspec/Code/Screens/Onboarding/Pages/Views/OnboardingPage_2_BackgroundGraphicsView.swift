//
//  OnboardingPage_2_BackgroundGraphicsView.swift
//  Inspec
//
//  Created by Justin Cook on 11/8/22.
//

import SwiftUI

struct OBP_2_BackgroundGraphicsView: View {
    let graphicsScaler = OBGraphicsScaler(idealImageSize: CGSize(width: 120, height: 120),
                                          idealImageOffset: CGPoint(x: 6, y: -15))
    
    var shapeCluster: Image {
        return Images.getImage(named: .shapeCluster)
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                shapeCluster
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

struct OBP_2_BackgroundGraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        OBP_2_BackgroundGraphicsView()
    }
}
