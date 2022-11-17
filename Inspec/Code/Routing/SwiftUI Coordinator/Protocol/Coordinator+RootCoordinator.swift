//
//  Coordinator+RootCoordinator.swift
//  Inspec
//
//  Created by Justin Cook on 11/1/22.
//

import SwiftUI

/// The coordinator pattern is used to greatly simplify the navigational logic of the application by abstracting the task of routing to new scenes, presenting popovers, bottom sheets, and web views, to a respective controller 'Coordinator'. This coordinator has child coordinators which it can manage, as well as be managed by a parent coordinator responsible for itself. At the top of the hierarchy is the root coordinator which is the first coordinator used to navigate the user through the application
// MARK: - Coordinator Protocol
public protocol Coordinator: ObservableObject {
    associatedtype Router: Routable
    associatedtype Body: View
    
    var parent: any Coordinator { get }
    var children: [any Coordinator] { get set }
    
    // Published instance variables
    var router: Router! { get set }
    var path: NavigationPath { get set }
    var pathRoutes: [Router.Route] { get set } // Keeps track of all current values in the nav path (active navigation paths)
    var sheetItem: Router.Route? { get set }
    var fullCoverItem: Router.Route? { get set }
    var rootView: AnyView! { get set }
    
    
    @ViewBuilder
    func start() -> Void // Any abstract logic to be executed when the coordinator is first initialized
}

// MARK: - Router interface + Coordinator on-init logic execution stub
extension Coordinator {
    func start() {}
    
    func view(for route: Router.Route) -> Self.Body {
        return router.view(for: route) as! Self.Body
    }
}

// MARK: - Child coordinator life cycle management
extension Coordinator {
    public func present(coordinator: any Coordinator) {
        addChild(coordinator)
        coordinator.start()
        rootView = coordinator.rootView
    }
    
    /// Check to see if the given coordinator is an active child of this coordinator
    public func doesChildExist(_ child: any Coordinator) -> Bool {
        return children.contains(where: { $0 === child })
    }
    
    public func getChild(for coordinator: any Coordinator) -> (any Coordinator)? {
        return children.first {
            $0 === coordinator
        }
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
    
    private func removeLastChild() {
        children.removeLast()
    }
    
    private func removeAllChildren() {
        children.removeAll()
    }
}

// MARK: - Modal + Navigation Stack presentation
extension Coordinator {
    /// Pushes a new view onto the navigation stack with the given route
    func pushView(with route: Router.Route,
                  onPresent: (() -> Void)? = nil) {
        addPath(with: route)
        completionHandler(onPresent)
    }
    
    /// Pops the topmost view off of the navigation stack
    func popView(with route: Router.Route,
                 onDismiss: (() -> Void)? = nil) {
        removePath(with: route)
        completionHandler(onDismiss)
    }
    
    /// Goes back to the root view in the navigation stack
    func popToRootView(onDismiss: (() -> Void)? = nil) {
        path = .init()
        pathRoutes.removeAll()
        completionHandler(onDismiss)
    }
    
    /// Pops to a specific view in the view hierarchy by dismissing all the views on top of it, cannot pop to the root view because the root is not a path in the navigation path
    func popToView(with route: Router.Route,
                   onDismiss: (() -> Void)? = nil) {
        guard pathRoutes.count > 0 else { return }
        
        for value in pathRoutes.reversed() {
            if value != route {
                popView(with: value)
            }
        }
        
        assert(pathRoutes.count != 0)
        completionHandler(onDismiss)
    }
    
    // MARK: - Fullscreen cover presentation
    func presentFullScreenCover(with route: Router.Route,
                                onPresent: (() -> Void)? = nil) {
        fullCoverItem = route
        completionHandler(onPresent)
    }
    func dismissFullScreenCover(onDismiss: (() -> Void)? = nil) {
        fullCoverItem = nil
        completionHandler(onDismiss)
    }
    
    // MARK: - Sheet presentation
    func presentSheet(with route: Router.Route,
                      onPresent: (() -> Void)? = nil) {
        sheetItem = route
        completionHandler(onPresent)
    }
    func dismissSheet(onDismiss: (() -> Void)? = nil) {
        sheetItem = nil
        completionHandler(onDismiss)
    }
    
    private func completionHandler(_ closure: (() -> Void)?) {
        closure?()
    }
    
    // MARK: - Navigation path management
    private func addPath(with route: Router.Route) {
        pathRoutes.append(route)
        path.append(route)
    }
    
    private func removeLastPathValue() {
        pathRoutes.removeLast()
        path.removeLast()
    }
    
    /// Not to be used by itself, this doesn't align with the FIFO behavior associated with the navigation path object
    private func removePath(with route: Router.Route) {
        pathRoutes.removeAll {
            $0.hashValue == route.hashValue
        }
    }
}

protocol RootCoordinator: Coordinator {
    var rootCoordinatorDelegate: RootCoordinatorDelegate { get set }
    var rootRoute: Router.Route { get }
    
    @ViewBuilder
    func coordinatorView() -> AnyView // A view that displays the coordinator's rootView, responsible for reflecting changes in the rootview hierarchy
}

protocol TabbarCoordinator: RootCoordinator {
    /// Returns the coordinator for the specified tabbar tab route, should be contained in the children store, if not then it will be instantiated and added to the children store
    func getCoordinatorFor(route: TabbarRoutes) -> any Coordinator
}

extension TabbarCoordinator {
    func getCoordinatorFor(route: TabbarRoutes) -> any Coordinator {
        var coordinator: any Coordinator
        
        switch route {
        case .builds:
            coordinator = BuildsCoordinator(parent: self)
        case .components:
            coordinator = ComponentsCoordinator(parent: self)
        case .command_center:
            coordinator = CommandCenterCoordinator(parent: self)
        case .explore:
            coordinator = ExploreCoordinator(parent: self)
        case .inbox:
            coordinator = InboxCoordinator(parent: self)
        }
        
        return doesChildExist(coordinator) ? getChild(for: coordinator) ?? coordinator : coordinator
    }
    
    /// The tabbar has specific children it manages, these children are never discarded throughout the tabbar's lifecycle so they're constant
    func populateChildren() {
        for route in MainRouter.Route.allCases {
            let child = getCoordinatorFor(route: route)
            addChild(child)
        }
    }
}
