//
//  HomeRouter.swift
//  zytrack_ios
//
//  Created by BrainX Technologies on 3/15/21.
//

import UIKit

class HomeRouter: Router {
    // MARK: - Instance Properties

    var viewController: BaseViewController?

    // MARK: - Init Methods

    required init(viewController: HomeViewController) {
        self.viewController = viewController
    }

    // MARK: - Public Methods

    func presentVC(routeType: RouteType, navigationType: NavigationType = .overlay, animated _: Bool = true, completion _: (() -> Void)? = nil) {
        guard let routeType = routeType as? HomeRouteType else {
            return
        }

        var vc: UIViewController

        switch routeType {
        case .Events:
            let viewController = UIViewController.instantiate(EventsViewController.self, fromStoryboard: .Main)
            vc = viewController
        }

        switch navigationType {
        case .root:
            viewController?.navigationController?.viewControllers = [vc]
        default:
            return
        }
    }
}
