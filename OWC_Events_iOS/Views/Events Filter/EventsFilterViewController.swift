//
//  EventsFilterViewController.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/26/21.
//

import UIKit

protocol UpdateSelectedValuesProtocol {
    func updateSelectedValues(typeThemeSelectedItems: [TypesAndThemeFilters], locationSelectedItems: [LocationFilters])
}

enum TypesAndThemeFilters: String, CaseIterable {
    case agriculture = "Agriculture"
    case arts = "Arts"
    case childrenAndYouth = "Children and Youth"
    case festivalsAndEvents = "Festivals and Events"
    case foodAndBeverage = "Food and Beverage"
    case heritage = "Heritage"
    case holidayCelebrations = "Holiday Celebrations"
    case liveMusic = "Live Music"
    case municipalMeetingsAndEvents = "Municipal Meetings and Events"
    case natureAndEnvironment = "Nature and Environment"
    case recreationAndSport = "Recreation and Sport"
    case tours = "Tours"
    case workshopsAndPresentation = "Workshops and Presentation"
}

enum LocationFilters: String, CaseIterable {
    case goderich = "Goderich"
    case municipalityOfBluewater = "Municipality of Bluewater"
    case municipalityOfCentralHuron = "Municipality of Central Huron"
    case municipalityOfHuronEast = "Municipality of Huron East"
    case municipalityOfMorrisTurnberry = "Municipality of Morris-Turnberry"
    case municipalityOfSouthHuron = "Municipality of South Huron"
    case townshipOfAshfield = "Township of Ashfield-Colborne-Wawanosh"
    case townshipOfHowick = "Township of Howick"
    case townshipOfNorthHuron = "Township of North Huron"
}

class EventsFilterViewController: BaseViewController {
    // MARK: Outlets

    @IBOutlet var eventsFilterView: EventsFilterView!

    // MARK: - Instance Variables

    private let typeThemeFilters = TypesAndThemeFilters.allCases
    private let locationFilters = LocationFilters.allCases
    private let headersArray = [LocalizedKey.typeTheme.string, LocalizedKey.location.string]
    private let eventsTableViewHeaderHeight: CGFloat = 50
    private var viewModel: EventsFilterViewModel!
    var delegate: UpdateSelectedValuesProtocol?
    var selectedDate = Date()
    var selectedTypeThemeFilters: [TypesAndThemeFilters] = []
    var selectedLocationFilters: [LocationFilters] = []

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        let router = EventsFilterRouter(controller: self)
        viewModel = EventsFilterViewModel(router: router)
        setupEventsTableView()
    }

    // MARK: - Private Methods

    private func setupEventsTableView() {
        eventsFilterView.filterTableView.delegate = self
        eventsFilterView.filterTableView.dataSource = self
        eventsFilterView.filterTableView.tableFooterView = UIView()
        eventsFilterView.filterTableView.bounces = false
        eventsFilterView.filterTableView.showsVerticalScrollIndicator = false
        eventsFilterView.filterTableView.separatorStyle = .none
        eventsFilterView.filterTableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: eventsFilterView.filterTableView.bounds.size.width, height: eventsTableViewHeaderHeight))
        eventsFilterView.filterTableView.contentInset = UIEdgeInsets(top: -eventsTableViewHeaderHeight, left: 0, bottom: 0, right: 0)
    }

    private func addBottomRadiusAndBorder(_ cell: UITableViewCell, _ indexPath: IndexPath, _ tableView: UITableView) {
        let cornerRadius: CGFloat = 10.0
        cell.backgroundColor = UIColor.clear
        let layer = CAShapeLayer()
        let pathRef = CGMutablePath()
        let bounds: CGRect = cell.bounds.insetBy(dx: 0, dy: 0)
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY), transform: CGAffineTransform())
            pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
            pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
        } else {
            pathRef.addRect(bounds)
        }
        layer.path = pathRef
        layer.fillColor = Color.grayColor.cgColor
        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, at: 0)
        testView.backgroundColor = UIColor.clear
        cell.backgroundView = testView
    }

    // MARK: - Action Methods

    @IBAction
    func handleClosedButton(_: Any) {
        viewModel.closedButtonPressed()
    }

    @IBAction
    func handleSelectAllButton(_: Any) {
        selectedTypeThemeFilters = TypesAndThemeFilters.allCases
        selectedLocationFilters = LocationFilters.allCases
        eventsFilterView.filterTableView.reloadData()
    }

    @IBAction
    func handleApplyFiltersButton(_: Any) {
        delegate?.updateSelectedValues(typeThemeSelectedItems: selectedTypeThemeFilters, locationSelectedItems: selectedLocationFilters)
        viewModel.closedButtonPressed()
    }

    @IBAction
    func handleCancelButton(_: Any) {
        selectedTypeThemeFilters = []
        selectedLocationFilters = []
        eventsFilterView.filterTableView.reloadData()
    }
}

// MARK: - TableView Delegate and DataSource Methods

extension EventsFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 2
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return typeThemeFilters.count
        default:
            return locationFilters.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: EventsFilterTableViewCell.reuseIdentifier,
            for: indexPath
        ) as! EventsFilterTableViewCell
        switch indexPath.section {
        case 0:
            cell.updateViewsWith(typeName: typeThemeFilters[indexPath.row].rawValue)
            cell.lineView.isHidden = indexPath.row == (typeThemeFilters.count - 1)
            cell.updateSelectedFilter(isSelected: selectedTypeThemeFilters.contains(typeThemeFilters[indexPath.row]))
        default:
            cell.updateViewsWith(typeName: locationFilters[indexPath.row].rawValue)
            cell.lineView.isHidden = indexPath.row == (locationFilters.count - 1)
            cell.updateSelectedFilter(isSelected: selectedLocationFilters.contains(locationFilters[indexPath.row]))
        }
        addBottomRadiusAndBorder(cell, indexPath, tableView)
        return cell
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            selectedTypeThemeFilters.append(typeThemeFilters[indexPath.row])
        default:
            selectedLocationFilters.append(locationFilters[indexPath.row])
        }
        eventsFilterView.filterTableView.reloadData()
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return eventsTableViewHeaderHeight
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = EventsFilterTableViewHeader()
        header.set(title: headersArray[section])
        return header
    }

    func tableView(_: UITableView, heightForFooterInSection _: Int) -> CGFloat {
        return eventsTableViewHeaderHeight / 2
    }

    func tableView(_: UITableView, viewForFooterInSection _: Int) -> UIView? {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = Color.backgroundPrimary
        return view
    }
}
