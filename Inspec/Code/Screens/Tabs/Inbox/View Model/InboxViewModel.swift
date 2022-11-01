//
//  InboxViewModel.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

class InboxViewModel: ObservableObject, Identifiable {
    private unowned let coordinator: InboxCoordinator
    
    init (coordinator: InboxCoordinator) {
        self.coordinator = coordinator
    }
    
    /// Present the detail view for this build profile item through the coordinator
    func display() {
        
    }
}
