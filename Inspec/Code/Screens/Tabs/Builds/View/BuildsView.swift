//
//  BuildsView.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

struct BuildsView: View {
    @ObservedObject var viewModel: BuildsViewModel
    
    var body: some View {
        Text("Builds")
    }
}

struct BuildsView_Previews: PreviewProvider {
    static var previews: some View {
        BuildsView(viewModel: .init(coordinator: BuildsCoordinator(parent: MainCoordinator())))
    }
}
