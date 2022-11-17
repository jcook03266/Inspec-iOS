//
//  RootCoordinatorView.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

///The central scene in the application, all other scenes are presented through this view
struct MainCoordinatorView: View {
    @StateObject var coordinator: MainCoordinator
    
    var currentTab: TabbarRoutes {
        return coordinator.currentTab
    }
    var tabbar: some View {
        return TabbarSelector(coordinator: coordinator).getTabbarFromUserPreference()
    }
    
    var body: some View {
        ZStack{
            NavigationStack(path: $coordinator.path) {
                coordinator.rootView
                    .fullScreenCover(item: $coordinator.fullCoverItem,
                                     content: { route in coordinator.view(for: route)
                    })
                    .sheet(item: $coordinator.sheetItem,
                           content: { route in coordinator.view(for: route)
                    })
                    .navigationDestination(for: TabbarRoutes.self,
                                           destination: { route in coordinator.view(for: route)
                    })
            }
            
            FloatingTabbar(coordinator: coordinator)
        }
    }
}
