//
//  EventsDetailViewModel.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/26/21.
//

import Foundation

class EventsDetailViewModel {
    // MARK: - Instance Properties

    private var router: EventsDetailRouter

    // MARK: - Init Methods

    required init(router: EventsDetailRouter) {
        self.router = router
    }

    // MARK: - Public Methods

    func backButtonPressed() {
        router.dismissVC(navigationType: .stack, animated: true, completion: nil)
    }
}
