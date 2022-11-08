//
//  LottieView.swift
//  Inspec
//
//  Created by Justin Cook on 11/7/22.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let animationName: LottieAnimationRepository
    var loopMode: LottieLoopMode = .loop
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> some UIView {
        let view = UIView(frame: .zero)
        
        // init animation view w/ specified animation
        let animationView = LottieAnimationView()
        let animation = LottieAnimations.getAnimation(named: animationName)
        
        // Set properties
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.backgroundBehavior = .pauseAndRestore
        animationView.shouldRasterizeWhenIdle = true
        animationView.loopMode = loopMode
        animationView.play()
        
        // Add subview and activate layout constraints
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
                                     animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
                                    ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<LottieView>) {
    }
}
