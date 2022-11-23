//
//  LaunchScreenBridgeViewModel.swift
//  Inspec
//
//  Created by Justin Cook on 11/22/22.
//

import SwiftUI

class LaunchScreenBridgeViewModel: ObservableObject {
    // MARK: - Assets
    var launchScreenImage: Image = Images.getImage(named: .Ian_Portrait_White_Border_512px)
    
    // MARK: Styling
    // Color
    var backgroundGradient: LinearGradient = Colors.gradient_1
    var foregroundColor: Color = Colors.text_white.0
    var textColor: Color = Colors.text_white.0
    // Font
    var appNameTextFont: FontRepository = .heading_0
    
    // MARK: - Localized Text
    var appNameText: LocalizedStringKey = LocalizedStrings.getLocalizedStringKey(for: .APP_NAME)
    
    // MARK: - Dimensions
    var launchScreenImageSize: CGSize = CGSize(width: 290, height: 244)
    
    // MARK: - Component Circle View Models
    var componentCircleViewModels: [ComponentCircleViewModel] {
        let refRadius = ComponentCircleViewModel.referencecircleRadius
        // The amount of offset the circle needs to have to be outside of the center icon's view content
        let exteriorOffset = refRadius * 1.9

        let offset_1 = CGSize(width: 0, height: -exteriorOffset),
         offset_2 = CGSize(width: -exteriorOffset/2, height: exteriorOffset/2).scaleBy(UnitCircle.degrees_45).negated(),
         offset_3 = CGSize(width: exteriorOffset, height: 0),
         offset_4 = CGSize(width: exteriorOffset/2, height: exteriorOffset/2).scaleBy(UnitCircle.degrees_45),
         offset_5 = CGSize(width: 0, height: exteriorOffset),
         offset_6 = CGSize(width: exteriorOffset/2, height: -exteriorOffset/2).scaleBy(UnitCircle.degrees_45).negated(),
         offset_7 = CGSize(width: -exteriorOffset, height: 0),
         offset_8 = CGSize(width: exteriorOffset/2, height: exteriorOffset/2).scaleBy(UnitCircle.degrees_45).negated()
        
        return [
            ComponentCircleViewModel(offset: offset_1,
                                     componentImage: Images.getImage(named: .gpu),
                                     animationDelay: 0.5) // Component 1
            ,ComponentCircleViewModel(offset: offset_2,
                                     componentImage: Images.getImage(named: .cpu),
                                     animationDelay: 0.6) // Component 2
            ,ComponentCircleViewModel(offset: offset_3,
                                     componentImage: Images.getImage(named: .motherboard),
                                     animationDelay: 0.7) // Component 3
            ,ComponentCircleViewModel(offset: offset_4,
                                      componentImage: Images.getImage(named: .ram),
                                      animationDelay: 0.8) // Component 4
            ,ComponentCircleViewModel(offset: offset_5,
                                      componentImage: Images.getImage(named: .ssd),
                                      animationDelay: 0.9) // Component 5
            ,ComponentCircleViewModel(offset: offset_6,
                                      componentImage: Images.getImage(named: .cpu_cooler),
                                      animationDelay: 1) // Component 6
            ,ComponentCircleViewModel(offset: offset_7,
                                      componentImage: Images.getImage(named: .water_cooler),
                                      animationDelay: 1.1) // Component 7
            ,ComponentCircleViewModel(offset: offset_8,
                                      componentImage: Images.getImage(named: .gaming_pc),
                                      animationDelay: 1.2) // Component 8
        ]
    }
    
    init() {}
    
    // MARK: - Component circle view
    struct ComponentCircle: View {
        // MARK: - Observed
        @StateObject var model: ComponentCircleViewModel
        
        // MARK: - Styling
        let backgroundColor: Color = Colors.text_white.0,
        borderWidth: CGFloat = 3,
        borderColor: Color = Colors.secondary_1.0
        
        var componentImage: some View {
            model.componentImage
                .resizable()
                .frame(width: model.imageRadius, height: model.imageRadius)
        }
        
        var body: some View {
            componentImage
                .background(
                    ZStack {
                        Circle()
                            .fill(backgroundColor)
                        
                        Circle()
                            .strokeBorder(borderColor,
                                          lineWidth: borderWidth)
                    }
                        .frame(width: model.circleRadius, height: model.circleRadius)
                )
                .offset(model.moveToOffset ? model.offset : .zero)
                .rotationEffect(.degrees(model.rotation))
                .animation(
                    .spring(response: 1.5)
                    .delay(model.animationDelay),
                    value: model.moveToOffset)
                .onAppear {
                    model.moveToOffset = true
                    model.rotation = 360
                    
                    resetAnimation()
                }
        }
        
        private func resetAnimation() {
            DispatchQueue.main.asyncAfter(
                deadline: .now() + LaunchScreenManager.displayDuration - 1.5) {
                    withAnimation(.spring(response: 2)) {
                        model.moveToOffset = false
                        model.rotation = 0
                    }
            }
        }
    }
    
    class ComponentCircleViewModel: GenericViewModel {
        // MARK: - Model Properties
        var id: UUID
        
        // MARK: - Animation properties
        var animationDelay: CGFloat = 0
        
        // MARK: - Assets
        var componentImage: Image = Images.getImage(named: .google)
        
        // MARK: - Published, Animation triggers
        @Published var moveToOffset: Bool = false
        @Published var rotation: CGFloat = 0
        
        // MARK: - Offset from origin
        var offset: CGSize
        
        // MARK: Dimensions
        var circleRadius: CGFloat = 75
        static var referencecircleRadius: CGFloat {
            return 75
        }
        
        var imageRadius: CGFloat {
            return self.circleRadius * 0.6
        }
        
        init(id: UUID = .init(),
             offset: CGSize,
             componentImage: Image,
             animationDelay: CGFloat) {
            self.id = id
            self.offset = offset
            self.componentImage = componentImage
            self.animationDelay = animationDelay
        }
    }
}
