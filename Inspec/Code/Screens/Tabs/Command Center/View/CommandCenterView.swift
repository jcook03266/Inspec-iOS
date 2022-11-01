//
//  CommandCenterView.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

struct CommandCenterView: View {
    @ObservedObject var viewModel: CommandCenterViewModel
    
    var body: some View {
        Text("Command Center")
    }
}

struct CommandCenterView_Previews: PreviewProvider {
    static var previews: some View {
        CommandCenterView(viewModel: .init(coordinator: CommandCenterCoordinator(parent: RootCoordinator())))
    }
}
