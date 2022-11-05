//
//  InboxView.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

struct InboxView: View {
    @ObservedObject var viewModel: InboxViewModel
    
    var body: some View {
        Text("In-app Messaging Coming Soon.")
    }
}

struct InboxView_Previews: PreviewProvider {
    static var previews: some View {
        InboxView(viewModel: .init(coordinator: InboxCoordinator(parent: RootCoordinator())))
    }
}
