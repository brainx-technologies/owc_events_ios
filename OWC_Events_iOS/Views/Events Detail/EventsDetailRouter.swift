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

    func dismissVC(navigationType _: NavigationType, animated: Bool, completion _: (() -> Void)?) {
        viewController?.navigationController?.popViewController(animated: animated)
    }

    func showActionSheet(alert: UIAlertController, animated: Bool, completion: (() -> Void)?) {
        viewController?.present(alert, animated: animated, completion: completion)
    }
}
