//
//  EventsFilterViewModel.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/27/21.
//

import Foundation

class EventsFilterViewModel {
    // MARK: - Instance Properties

    private var router: EventsFilterRouter

    // MARK: - Init Methods

    required init(router: EventsFilterRouter) {
        self.router = router
    }

    // MARK: - Public Methods

    func closedButtonPressed() {
        router.dismissVC(navigationType: .stack, animated: true, completion: nil)
    }
}
