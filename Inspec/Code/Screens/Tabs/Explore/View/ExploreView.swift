//
//  ExploreView.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

struct ExploreView: View {
    @ObservedObject var viewModel: ExploreViewModel
    
    var body: some View {
        Text("Explore")
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(viewModel: .init(coordinator: ExploreCoordinator(parent: RootCoordinator())))
    }
}
