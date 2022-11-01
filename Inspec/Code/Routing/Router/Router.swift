//
//  Router.swift
//  Inspec
//
//  Created by Justin Cook on 10/29/22.
//

import UIKit
import SwiftUI

class ViewRouter: ObservableObject {
    @Published var currentTab: Tabs = .builds
    var tabbarTabController: TabbarTabDispatcher {
        return TabbarTabDispatcher(router: self)
    }
    
    var currentScreen: some View {
        return tabbarTabController.getViewFor(tab: currentTab)
    }
    
    init() {
    }
}
