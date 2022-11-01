//
//  ComponentsViewModel.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

class ComponentsViewModel: ObservableObject, Identifiable {
    private unowned let coordinator: ComponentsCoordinator
    
    init (coordinator: ComponentsCoordinator) {
        self.coordinator = coordinator
    }
    
    /// Present the detail view for this build profile item through the coordinator
    func display() {
        
    }
}
