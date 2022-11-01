//
//  CommandCenterCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI
import UIKit

class CommandCenterCoordinator: Coordinator {
    unowned let parent: any Coordinator
    var children: [any Coordinator] = []
    
    init (parent: any Coordinator) {
        self.parent = parent
    }
    
    func present(animated: Bool,
                 onDismiss: (() -> Void)?)
    {}
}
