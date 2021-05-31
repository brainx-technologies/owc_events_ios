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
    case MonthYearPickerView(data: Any? = nil)
}

class EventsViewController: BaseViewController {
    // MARK: Outlets

    @IBOutlet var eventsView: EventsView!

    // MARK: - Instance Variables

    private let heightForEventsRow: CGFloat = 200
    private var totalFilterBeingApplied = 0
    var viewModel: EventsViewModel!
    var selectedDate = Date()
    var isSearchResult: Bool? {
        didSet {
            if isSearchResult ?? false {
                eventsView.noEventsLabel.text = LocalizedKey.noEventFound.string
                eventsView.noEventsImageView.image = UIImage(named: Image.noEventFound)
            } else {
                eventsView.noEventsLabel.text = LocalizedKey.noEventsAvailable.string
                eventsView.noEventsImageView.image = UIImage(named: Image.noEvents)
            }
        }
    }

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        let router = EventsRouter(controller: self)
        viewModel = EventsViewModel(router: router)
        eventsView.calendarView.addTapAction(#selector(handleDatePicker), target: self)
        eventsView.filterView.addTapAction(#selector(handleFilter), target: self)
        eventsView.searchIconImageView.addTapAction(#selector(handleClearSearch), target: self)
        eventsView.searchTextField.delegate = self
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
        FilterManager.getFilterBeingApplied { typeThemeFilters, locationFilter in
            self.totalFilterBeingApplied = typeThemeFilters.count + locationFilter.count
            self.eventsView.filterNumberLabel.text = "\(self.totalFilterBeingApplied)"
        }
    }

    private func fetchDataFor(date _: Date) {}

    // MARK: - Action Methods

    @objc
    private func handleDatePicker() {
        viewModel.loadMonthYearPickerViewWith(selectedDate: selectedDate)
    }

    @objc
    private func handleFilter() {
        viewModel.loadFilterViewController()
    }

    @objc
    private func handleClearSearch() {
        if eventsView.searchIconImageView.image == UIImage(systemName: Image.xMark) {
            eventsView.searchTextField.text = LocalizedKey.empty.string
        }
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
        viewModel.loadDetailsViewController()
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return heightForEventsRow
    }
}

// MARK: - UITextFieldDelegate Methods

extension EventsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_: UITextField) {
        eventsView.searchIconImageView.image = UIImage(systemName: Image.search)
        isSearchResult = eventsView.searchTextField.hasText
        //        Hit API
    }

    func textFieldDidBeginEditing(_: UITextField) {
        eventsView.searchIconImageView.image = UIImage(systemName: Image.xMark)
        isSearchResult = true
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        eventsView.searchTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Protocol Methods

extension EventsViewController: UpdateSelectedValuesProtocol {
    func updateSelectedValues(typeThemeSelectedItems: [TypesAndThemeFilters], locationSelectedItems: [LocationFilters]) {
        totalFilterBeingApplied = typeThemeSelectedItems.count + locationSelectedItems.count
        eventsView.filterNumberLabel.text = "\(totalFilterBeingApplied)"
    }
}

// MARK: - Protocol Methods

extension EventsViewController: UpdateMonthYearProtocol {
    func updatedMonthAndYear(date: Date) {
        selectedDate = date
        eventsView.dateLabel.text = Date.monthYearFormatter.string(from: selectedDate)
    }
}
