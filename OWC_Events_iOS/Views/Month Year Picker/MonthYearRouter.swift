//
//  MonthYearRouter.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/31/21.
//

import UIKit

class MonthYearRouter: Router {
    // MARK: - Instance variable

    var viewController: BaseViewController?

    // MARK: - Init Method

    required init(controller: MonthYearPickerViewController) {
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
}
