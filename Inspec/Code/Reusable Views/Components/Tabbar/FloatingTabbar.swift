//
//  FloatingTabbar.swift
//  Inspec
//
//  Created by Justin Cook on 10/28/22.
//

import SwiftUI

struct FloatingTabbar: View {
    @StateObject var router: ViewRouter
    @Namespace private var tabbarContainer
    @State private var animate: Bool = false
    
    var cornerRadius: CGFloat = 40,
        height: CGFloat = 40,
        color: Color = Colors.white.0,
        shadowColor: Color = Colors.shadow_1.0
    
    let itemSpacing: CGFloat = 20
    
    var tabButtons: some View {
        ForEach(Tabs.allCases, id: \.rawValue) { tab in
            if tab != .command_center {
                VStack(spacing: 3) {
                    router.tabbarTabController.getTabViewFor(tab: tab)
                        .zIndex(0)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                router.currentTab = tab
                                
                                animate.toggle()
                            }
                        }
                    
                    if router.currentTab == tab && tab != .command_center {
                        TabbarButtonUnderlineView()
                            .zIndex(0)
                            .matchedGeometryEffect(id: "underline", in: tabbarContainer)
                            .animation(Animation.easeInOut(duration: 0.2))
                        
                        Spacer()
                    }
                }
                .fixedSize()
            }
            else {
                router.tabbarTabController.getTabViewFor(tab: tab)
                    .zIndex(1)
                    .matchedGeometryEffect(id: "centerIcon",
                                           in: tabbarContainer)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            router.currentTab = tab
                        }
                    }
            }
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                GeometryReader { geom in
                    HStack(spacing: itemSpacing) {
                        Spacer()
                        
                        tabButtons
                        
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: cornerRadius)
                        .foregroundColor(color)
                        .frame(width: geom.size.width * 0.95, height: height)
                        .shadow(color: shadowColor,
                                radius: 2,
                                x: 0,
                                y: 2))
                    .frame(width: geom.size.width * 1, height: height)
                }
            }
            .frame(height: height)
            .withFont(.body_3XS)
        }
    }
}

struct FloatingTabbar_Previews: PreviewProvider {
    static var previews: some View {
        FloatingTabbar(router: ViewRouter())
    }
}
