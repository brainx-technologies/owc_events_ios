//
//  EventsViewController.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/24/21.
//

import ActionSheetPicker_3_0
import UIKit

enum DayOfWeek: CaseIterable {
    case monday, tuesday, wednesday, thursday, friday, saturday, sunday

    var name: String {
        switch self {
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thu"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        case .sunday: return "Sun"
        }
    }

    func getDate(forWeek weekStartDate: Date) -> Date? {
        let calendar = Calendar.gregorian
        let offset: Int

        switch self {
        case .monday: offset = 0
        case .tuesday: offset = 1
        case .wednesday: offset = 2
        case .thursday: offset = 3
        case .friday: offset = 4
        case .saturday: offset = 5
        case .sunday: offset = 6
        }

        let date = calendar.date(
            byAdding: .day,
            value: offset,
            to: weekStartDate
        )

        return date
    }
}

enum MonthsOfYear: String, CaseIterable {
    case January, February, March, April, May, June, July, August, September, October, November, December

    static func getMonthsNames() -> [String] {
        var names: [String] = []
        MonthsOfYear.allCases.forEach { month in
            names.append(month.rawValue)
        }
        return names
    }
}

enum EventsRouteType: RouteType {
    case FilterView(data: Any? = nil)
    case EventsDetail(data: Any? = nil)
}

class EventsViewController: BaseViewController {
    // MARK: Outlets

    @IBOutlet var eventsView: EventsView!

    // MARK: - Instance Variables

    private let heightForEventsRow: CGFloat = 200
    var viewModel: EventsViewModel!
    var selectedDate = Date()

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        let router = EventsRouter(controller: self)
        viewModel = EventsViewModel(router: router)
        eventsView.calendarView.addTapAction(#selector(handleDatePicker), target: self)
        eventsView.filterView.addTapAction(#selector(handleFilter), target: self)
        setupEventsTableView()
        setupViews()
    }

    // MARK: - Private Methods

    private func setupEventsTableView() {
        eventsView.eventsTableView.delegate = self
        eventsView.eventsTableView.dataSource = self
    }

    private func setupViews() {
        eventsView.dateLabel.text = Date.monthYearFormatter.string(from: selectedDate)
    }

    private func fetchDataFor(date _: Date) {}

    // MARK: - Action Methods

    @objc
    private func handleDatePicker() {
        ActionSheetDatePicker.show(
            withTitle: LocalizedKey.selectDate.string,
            datePickerMode: .date,
            selectedDate: selectedDate,
            doneBlock: {
                _, date, _ in
                self.selectedDate = date as? Date ?? Date()
                self.eventsView.dateLabel.text = Date.monthYearFormatter.string(from: self.selectedDate)
                self.eventsView.eventsTableView.reloadData()
                self.fetchDataFor(date: self.selectedDate)
            },
            cancel: nil,
            origin: eventsView
        )
    }

    @objc
    private func handleFilter() {
        viewModel.LoadFilterViewController()
    }
}

// MARK: - TableView Delegate and DataSource Methods

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: EventsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! EventsTableViewCell
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        viewModel.LoadDetailsViewController()
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return heightForEventsRow
    }
}
