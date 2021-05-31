//
//  EventsViewModel.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/26/21.
//

import Foundation

class EventsViewModel {
    // MARK: - Instance Properties

    private var router: EventsRouter

    // MARK: - Init Methods

    required init(router: EventsRouter) {
        self.router = router
    }

    // MARK: - Public Methods

    func loadFilterViewController() {
        router.presentVC(routeType: EventsRouteType.FilterView(), navigationType: .overlay, animated: false, completion: nil)
    }

    func loadDetailsViewController() {
        router.presentVC(routeType: EventsRouteType.EventsDetail(), navigationType: .stack, animated: false, completion: nil)
    }

    func loadMonthYearPickerViewWith(selectedDate: Date) {
        router.presentVC(routeType: EventsRouteType.MonthYearPickerView(data: selectedDate), navigationType: .overlay, animated: false, completion: nil)
    }
}
