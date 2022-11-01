//
//  BuildsViewModel.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

class BuildsViewModel: ObservableObject, Identifiable {
    private unowned let coordinator: BuildsCoordinator
    
    init (coordinator: BuildsCoordinator) {
        self.coordinator = coordinator
    }
    
    /// Present the detail view for this build profile item through the coordinator
    func display() {
        
    }
}
