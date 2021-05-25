//
//  HomeViewModel.swift
//  zytrack_ios
//
//  Created by BrainX Technologies on 3/15/21.
//

import UIKit

class HomeViewModel {
    // MARK: - Instance Properties

    private var router: HomeRouter

    // MARK: - Init Methods

    required init(router: HomeRouter) {
        self.router = router
    }

    // MARK: - Public Methods

    func LoadEventsViewController() {
        router.presentVC(routeType: HomeRouteType.Events(), navigationType: .root, animated: false, completion: nil)
    }
}
