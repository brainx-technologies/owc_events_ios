//
//  EventsRouter.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/26/21.
//

import UIKit

class EventsRouter: Router {
    // MARK: - Instance variable

    var viewController: BaseViewController?

    // MARK: - Init Method

    required init(controller: EventsViewController) {
        viewController = controller
    }

    // MARK: - Public Methods

    func dismissVC(routeType _: RouteType, navigationType _: NavigationType, animated: Bool, completion _: (() -> Void)?) {
        viewController?.navigationController?.popViewController(animated: animated)
    }

    func dismissVC(navigationType: NavigationType, animated: Bool, completion: (() -> Void)?) {
        switch navigationType {
        case .overlay:
            viewController?.dismiss(animated: animated, completion: completion)
        case .stack:
            viewController?.navigationController?.popViewController(animated: animated)
        case .root:
            viewController?.dismiss(animated: animated, completion: nil)
        }
    }

    func presentVC(routeType: RouteType, navigationType: NavigationType, animated: Bool, completion: (() -> Void)?) {
        guard let routeType = routeType as? EventsRouteType else {
            return
        }

        let vc: UIViewController

        switch routeType {
        case .FilterView:
            let dateFilterVC = UIViewController.instantiate(EventsFilterViewController.self, fromStoryboard: .Home)
            let eventViewController: EventsViewController = viewController as! EventsViewController
            dateFilterVC.delegate = eventViewController
            vc = dateFilterVC
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .coverVertical

        case let .EventsDetail(eventStartDate):
            let detailReportController = UIViewController.instantiate(EventsDetailViewController.self, fromStoryboard: .Home)
            if let date = eventStartDate as? Date {
                detailReportController.selectedDate = date
            }
            vc = detailReportController
        case let .MonthYearPickerView(selectedDate):
            let monthYearPickerController = UIViewController.instantiate(MonthYearPickerViewController.self, fromStoryboard: .Home)
            let eventViewController: EventsViewController = viewController as! EventsViewController
            monthYearPickerController.monthYearDelegate = eventViewController
            if let date = selectedDate as? Date {
                monthYearPickerController.selectedMonth = date.get(.month)
                monthYearPickerController.selectedYear = date.get(.year)
            }
            vc = monthYearPickerController
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = eventViewController
        }

        switch navigationType {
        case .overlay:
            viewController?.present(vc, animated: animated, completion: completion)
        case .stack:
            viewController?.navigationController?.pushViewController(vc, animated: animated)
        case .root:
            viewController?.navigationController?.viewControllers = [vc]
        }
    }
}
