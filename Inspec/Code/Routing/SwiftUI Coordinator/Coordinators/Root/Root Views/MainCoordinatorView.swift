//
//  RootCoordinatorView.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

///The central scene in the application, all other scenes are presented through this view
struct MainCoordinatorView: CoordinatedView {
    typealias Router = MainRouter
    typealias Coordinator = MainCoordinator
    
    // MARK: - Observed
    @StateObject var coordinator: MainCoordinator
    
    // MARK: - Navigation States
    @State var sheetItemState: TabbarRoutes? = nil
    @State var fullCoverItemState: TabbarRoutes? = nil
    
    var currentTab: TabbarRoutes {
        return coordinator.currentTab
    }
    var tabbar: some View {
        return TabbarSelector(coordinator: coordinator).getTabbarFromUserPreference()
    }
    
    var body: some View {
        ZStack{
            synchronize(publishedValues: [$coordinator.fullCoverItem, $coordinator.sheetItem],
                        with: [$fullCoverItemState, $sheetItemState]) {
                NavigationStack(path: $coordinator.path) {
                    coordinator.rootView
                        .fullScreenCover(item: $fullCoverItemState,
                                         content: { route in coordinator.router.view(for: route) })
                        .sheet(item: $sheetItemState,
                               content: { route in coordinator.router.view(for: route) })
                        .navigationDestination(for: Router.Route.self,
                                               destination: { route in coordinator.router.view(for: route) })
                }
            }
            
            FloatingTabbar(coordinator: coordinator)
        }
        .statusBarHidden(coordinator.statusBarHidden)
    }
}
