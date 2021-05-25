//
//  Router.swift
//  ZyTrack
//
//  Created by BrainX Technologies on 2/19/21.
//

import UIKit

protocol RouteType {}

enum NavigationType {
    case overlay
    case stack
    case root
}

protocol Router {
    var viewController: BaseViewController? { get set }

    // Methods for presenting view controller
    func presentVC(routeType: RouteType, navigationType: NavigationType, animated: Bool, completion: (() -> Void)?)

    // Methods for pushing view controller
    func dismissVC(navigationType: NavigationType, animated: Bool, completion: (() -> Void)?)
}

extension Router {
    func presentVC(_ routeType: RouteType, navigationType: NavigationType = .overlay,
                   animated: Bool = true, completion: (() -> Void)? = nil)
    {
        presentVC(routeType: routeType, navigationType: navigationType, animated: animated, completion: completion)
    }

    func presentVC(routeType _: RouteType, navigationType _: NavigationType, animated _: Bool, completion _: (() -> Void)?) {}

    func dismissVC(navigationType _: NavigationType, animated _: Bool, completion _: (() -> Void)?) {}
}
