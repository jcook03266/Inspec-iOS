//
//  RootCoordinatorView.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

///The central scene in the application, all other scenes are presented through this view
struct RootCoordinatorView: View {
    @ObservedObject var rootCoordinator: RootCoordinator
    
    var currentScreen: some View {
        return rootCoordinator.getScreenFor(tab: rootCoordinator.currentTab)
    }
    
    var body: some View {
        ZStack{
            self.currentScreen
         
            FloatingTabbar(coordinator: rootCoordinator)
        }
    }
}
