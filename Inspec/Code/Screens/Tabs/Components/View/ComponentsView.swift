//
//  ComponentsView.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

struct ComponentsView: View {
    @ObservedObject var viewModel: ComponentsViewModel
    
    var body: some View {
        Text("Components")
    }
}

struct ComponentsView_Previews: PreviewProvider {
    static var previews: some View {
        ComponentsView(viewModel: ComponentsViewModel(coordinator: ComponentsCoordinator(parent: RootCoordinator())))
    }
}
