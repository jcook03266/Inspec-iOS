//
//  Coordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

/// The coordinator pattern is used to greatly simplify the navigational logic of the application by abstracting the task of routing to new scenes, presenting popovers, bottom sheets, and web views, to a respective controller 'Coordinator'. This coordinator has child coordinators which it can manage, as well as be managed by a parent coordinator responsible for itself. At the top of the hierarchy is the root coordinator which is the first coordinator used to navigate the user through the application
// MARK: - Coordinator Protocol
public protocol Coordinator: ObservableObject {
    var parent: any Coordinator { get }
    var children: [any Coordinator] { get set }
    
    func present(animated: Bool, onDismiss: (() -> Void)?)
    func dismiss(animated: Bool)
    func presentChild(_ child: any Coordinator, animated: Bool, onDismiss: (() -> Void)?)
}

extension Coordinator {
    public func dismiss(animated: Bool) {
        
    }
    
    public func presentChild(_ child: any Coordinator,
                             animated: Bool,
                             onDismiss: (() -> Void)? = nil)
    {
        guard !doesChildExist(child) else { return }
        
        self.addChild(child)
        child.present(animated: animated,
                      onDismiss: {
            [weak self, weak child] in
            guard let self = self,
                  let child = child else {
                return
            }
            self.removeChild(child)
            onDismiss?()
        })
    }
    
    /// Check to see if the given coordinator is an active child of this coordinator
    public func doesChildExist(_ child: any Coordinator) -> Bool {
        return children.contains(where: { $0 === child })
    }
    
    public func getChild(at index: Int) -> (any Coordinator)? {
        return children[index]
    }
    
    public func addChild(_ child: any Coordinator) {
        guard !doesChildExist(child)
        else { return }
        
        children.append(child)
    }
    
    /// Remove child from children by testing to see if the given child exists in the array at the same point in memory as an identical child
    private func removeChild(_ child: any Coordinator) {
        guard let index = children.firstIndex(where: {
            $0 === child
        }) else {
            return
        }
        
        children.remove(at: index)
    }
}
