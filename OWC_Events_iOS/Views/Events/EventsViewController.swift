//
//  EventsViewController.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/24/21.
//

import UIKit

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

    private var keyboardHeight: CGFloat?
    private let heightForEventsRow: CGFloat = 200
    var selectedTypeThemeFilters: [TypesAndThemeFilters] = []
    var selectedLocationFilters: [LocationFilters] = []
    private var totalFilterBeingApplied = 0
    var viewModel: EventsViewModel!
    var selectedDate = Date()
    var OWCEvents: [OWCEvent] = []
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

    var isTableDataAvailable: Bool = false {
        didSet {
            eventsView.noEventsImageView.isHidden = isTableDataAvailable
            eventsView.noEventsLabel.isHidden = isTableDataAvailable
            eventsView.eventsTableView.isHidden = !isTableDataAvailable
            eventsView.eventsTableView.reloadData()
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
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
            self.eventsView.filterNumberView.isHidden = self.totalFilterBeingApplied == 0
            self.eventsView.filterNumberLabel.text = "\(self.totalFilterBeingApplied)"
            self.selectedTypeThemeFilters = typeThemeFilters
            self.selectedLocationFilters = locationFilter
        }
        viewModel.getDummyEvents { events in
            self.OWCEvents.removeAll()
            for event in events {
                if self.totalFilterBeingApplied == 0 {
                    self.OWCEvents = events
                    break
                }
                if let kinds = event.isKindOf {
                    for kind in kinds {
                        if let newFilter = TypesAndThemeFilters(rawValue: kind) {
                            if self.selectedTypeThemeFilters.contains(newFilter) {
                                self.OWCEvents.append(event)
                                break
                            }
                        }
                        if let newFilter = LocationFilters(rawValue: kind) {
                            if self.selectedLocationFilters.contains(newFilter) {
                                self.OWCEvents.append(event)
                                break
                            }
                        }
                    }
                }
            }
            self.isTableDataAvailable = self.OWCEvents.count > 0
        }
    }

    private func fetchDataFor(date _: Date) {
        // Will implement when API is available
    }

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
            updateSearchIconImage(textField: eventsView.searchTextField)
        } else {
            eventsView.searchTextField.becomeFirstResponder()
        }
    }

    @objc
    func keyboardWillShow(notification: NSNotification) {
        if let height = keyboardHeight {
            if eventsView.bottomFilterConstraint.constant < height { eventsView.bottomFilterConstraint.constant += height }
        } else {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                keyboardHeight = keyboardSize.height
                eventsView.bottomFilterConstraint.constant += keyboardHeight ?? 0
            }
        }
    }

    @objc
    func keyboardWillHide(notification _: NSNotification) {
        if let height = keyboardHeight {
            if eventsView.bottomFilterConstraint.constant > height { eventsView.bottomFilterConstraint.constant -= height }
        }
    }
}

// MARK: - TableView Delegate and DataSource Methods

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return OWCEvents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: EventsTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! EventsTableViewCell
        cell.updateWith(event: OWCEvents[indexPath.row])
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
    private func updateSearchIconImage(textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            eventsView.searchIconImageView.image = UIImage(systemName: Image.xMark)
        } else {
            eventsView.searchIconImageView.image = UIImage(systemName: Image.search)
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSearchIconImage(textField: textField)
        isSearchResult = eventsView.searchTextField.hasText
        //        Hit API
    }

    func textFieldDidBeginEditing(_: UITextField) {
        isSearchResult = true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateSearchIconImage(textField: textField)
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        eventsView.searchTextField.resignFirstResponder()
        return true
    }
}

// MARK: - Protocol Methods

extension EventsViewController: UpdateSelectedValuesProtocol {
    func updateSelectedValues(typeThemeSelectedItems: [TypesAndThemeFilters], locationSelectedItems: [LocationFilters]) {
        selectedTypeThemeFilters = typeThemeSelectedItems
        selectedLocationFilters = locationSelectedItems
        totalFilterBeingApplied = typeThemeSelectedItems.count + locationSelectedItems.count
        eventsView.filterNumberLabel.text = "\(totalFilterBeingApplied)"
        setupViews()
    }
}

// MARK: - Protocol Methods

extension EventsViewController: UpdateMonthYearProtocol {
    func updatedMonthAndYear(date: Date) {
        selectedDate = date
        eventsView.dateLabel.text = Date.monthYearFormatter.string(from: selectedDate)
    }
}
