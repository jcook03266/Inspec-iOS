//
//  Animations.swift
//  Inspec
//
//  Created by Justin Cook on 11/7/22.
//

import SwiftUI
import UIKit
import Lottie

// MARK: - Structs
struct LottieAnimations {
    static func getAnimation(named animationName: LottieAnimationRepository) -> LottieAnimation {
        guard let animation = LottieAnimation.named(animationName.rawValue) else {
            preconditionFailure("Error: The lottie animation JSON file named \(animationName) was not found, Function: \(#function)")
        }
        
        return animation
    }
    
    static var gpu_isometric: LottieAnimation {
        return getAnimation(named: .gpu_isometric)
    }
    
    static var ai_assistant_bot: LottieAnimation {
        return getAnimation(named: .ai_assistant_bot)
    }
    
    static var person_at_computer: LottieAnimation {
        return getAnimation(named: .person_at_computer)
    }
    
    static var teamwork: LottieAnimation {
        return getAnimation(named: .teamwork)
    }
}

// MARK: - Animation JSON File Enumerations
// Please update this repo whenever any new animations are added
enum LottieAnimationRepository: String, CaseIterable {
    case gpu_isometric,
         ai_assistant_bot,
         person_at_computer,
         teamwork
}


