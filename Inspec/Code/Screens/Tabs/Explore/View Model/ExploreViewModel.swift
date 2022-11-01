//
//  ExploreViewModel.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

class ExploreViewModel: ObservableObject, Identifiable {
    private unowned let coordinator: ExploreCoordinator
    
    init (coordinator: ExploreCoordinator) {
        self.coordinator = coordinator
    }
    
    /// Present the detail view for this build profile item through the coordinator
    func display() {
        
    }
}
