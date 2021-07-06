//
//  EventsViewModel.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/26/21.
//

import UIKit

enum WeekDay: Int {
    case sunday = 1
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday

    func getColor() -> UIColor {
        switch self {
        case .sunday:
            return Color.sunday
        case .monday:
            return Color.monday
        case .tuesday:
            return Color.tuesday
        case .wednesday:
            return Color.wednesday
        case .thursday:
            return Color.thursday
        case .friday:
            return Color.friday
        case .saturday:
            return Color.saturday
        }
    }
}

class EventsViewModel {
    // MARK: - Instance Properties

    private var router: EventsRouter

    // MARK: - Init Methods

    required init(router: EventsRouter) {
        self.router = router
    }

    // MARK: - Public Methods

    func loadFilterViewController() {
        router.presentVC(routeType: EventsRouteType.FilterView(), navigationType: .overlay, animated: true, completion: nil)
    }

    func loadDetailsViewController(selectedDate: Date) {
        router.presentVC(routeType: EventsRouteType.EventsDetail(data: selectedDate), navigationType: .stack, animated: true, completion: nil)
    }

    func loadMonthYearPickerViewWith(selectedDate: Date) {
        router.presentVC(routeType: EventsRouteType.MonthYearPickerView(data: selectedDate), navigationType: .overlay, animated: true, completion: nil)
    }

    func getDummyEvents(withCompletion completion: @escaping ([OWCEvent]) -> Void) {
        router.viewController?.showLoader(true)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
        var events: [OWCEvent] = []
        let endDate = Date().add(days: 1, hours: 2, minutes: 5, seconds: 14) ?? Date()
        events.append(OWCEvent(id: 0, title: "The Creative Coffee Talks Club", startDate: Date(), endDate: endDate, location: "40 Margaret St, Marylebone, London", kinds: ["Food and Beverage", "Agriculture"]))
        let startDate2 = Date().add(days: 1) ?? Date()
        let endDate2 = Date().add(days: 1, hours: 2, minutes: 5, seconds: 14) ?? Date()
        events.append(OWCEvent(id: 0, title: "Project daily stand-up", startDate: startDate2, endDate: endDate2, location: "40 Margaret St, Marylebone, London", kinds: ["Children and Youth", "Agriculture"]))
        completion(events)
        router.viewController?.showLoader(false)
//        }
    }
}
