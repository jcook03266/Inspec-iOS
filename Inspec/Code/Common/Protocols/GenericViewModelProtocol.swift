//
//  GenericViewModelProtocol.swift
//  Inspec
//
//  Created by Justin Cook on 11/12/22.
//

import SwiftUI

/// Basis for observable view models, allows a view to respond to changes within the target object's values
protocol GenericViewModel: ObservableObject, Identifiable {
    var id: UUID { get }
}

/// Generic view model that conforms to the navigation protocol which allows for the movement between items in a collection, namely views to create a carousel of some sort
protocol NavigableGenericViewModel: GenericViewModel, GenericNavigationProtocol {
}
