//
//  EventsDetailRouter.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/26/21.
//

import UIKit

class EventsDetailRouter: Router {
    // MARK: - Instance variable

    var viewController: BaseViewController?

    // MARK: - Init Method

    required init(controller: EventsDetailViewController) {
        viewController = controller
    }

    // MARK: - Public Methods

    func dismissVC(routeType _: RouteType, navigationType _: NavigationType, animated: Bool, completion _: (() -> Void)?) {
        viewController?.navigationController?.popViewController(animated: animated)
    }

    func dismissVC(navigationType _: NavigationType, animated: Bool, completion _: (() -> Void)?) {
        viewController?.navigationController?.popViewController(animated: animated)
    }

//    func presentVC(routeType: RouteType, navigationType: NavigationType, animated: Bool, completion: (() -> Void)?) {
//        guard let routeType = routeType as? EventsRouteType else {
//            return
//        }
//
//        let vc: UIViewController
//
//        switch routeType {
//        case .FilterView:
//            let dateFilterVC = UIViewController.instantiate(EventsFilterViewController.self, fromStoryboard: .Main)
//            vc = dateFilterVC
//            vc.modalPresentationStyle = .overCurrentContext
//        case .EventsDetail:
//            let detailReportController = UIViewController.instantiate(EventsDetailViewController.self, fromStoryboard: .Main)
//            vc = detailReportController
//        }
//
//        switch navigationType {
//        case .overlay:
//            viewController?.present(vc, animated: animated, completion: completion)
//        case .stack:
//            viewController?.navigationController?.pushViewController(vc, animated: animated)
//        case .root:
//            viewController?.navigationController?.viewControllers = [vc]
//        }
//    }
}
