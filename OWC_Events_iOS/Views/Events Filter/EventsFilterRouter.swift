//
//  EventsFilterRouter.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/27/21.
//

import UIKit

class EventsFilterRouter: Router {
    // MARK: - Instance variable

    var viewController: BaseViewController?

    // MARK: - Init Method

    required init(controller: EventsFilterViewController) {
        viewController = controller
    }

    // MARK: - Public Methods

    func dismissVC(navigationType : NavigationType, animated: Bool, completion : (() -> Void)?) {
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
