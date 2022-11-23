//
//  OnboardingPage_1_BackgroundGraphicsView.swift
//  Inspec
//
//  Created by Justin Cook on 11/8/22.
//

import SwiftUI

struct OBP_1_BackgroundGraphicsView: View {
    /// Dashed circle
    let graphicsScaler_1 = OBGraphicsScaler(idealImageSize: CGSize(width: 160, height: 160),
                                          idealImageOffset: CGPoint(x: -22, y: -46))
    
    /// Dot matrix
    let graphicsScaler_2 = OBGraphicsScaler(idealImageSize: CGSize(width: 160, height: 160),
                                          idealImageOffset: CGPoint(x: 7, y: -40))
    
    var dashedCircle: Image {
        return Images.getImage(named: .dashedCircle)
    }
    var dotMatrixImage: Image {
        return Images.getImage(named: .dotMatrix)
    }
    
    // MARK: - States for animations
    @State private var rotation: CGFloat = 0
    
    var body: some View {
        VStack {
            HStack {
                // Animation: Rotates indefinitely
                dashedCircle
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(.degrees(rotation),
                                    anchor: .center)
                    .frame(width: graphicsScaler_1.realImageSize.width,
                           height: graphicsScaler_1.realImageSize.height)
                    .offset(x: graphicsScaler_1.realImageOffset.x,
                            y: graphicsScaler_1.realImageOffset.y)
                    .animation(
                        .linear(duration: 1)
                        .repeatForever(autoreverses: true)
                        .speed(0.1),
                        value: rotation)
                    .onAppear {
                        rotation = 360
                    }
    
                Spacer()
            }
            
            Spacer()
            
            HStack {
                dotMatrixImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: graphicsScaler_2.realImageSize.width,
                           height: graphicsScaler_2.realImageSize.height)
                    .offset(x: graphicsScaler_2.realImageOffset.x,
                            y: graphicsScaler_2.realImageOffset.y)
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

struct OBP_1_BackgroundGraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        OBP_1_BackgroundGraphicsView()
    }
}
