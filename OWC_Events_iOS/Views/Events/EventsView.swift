//
//  EventsView.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/24/21.
//

import UIKit

class EventsView: UIView {
    // MARK: Outlets

    @IBOutlet var eventsLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var calendarView: UIView!
    @IBOutlet var calendarImageView: UIImageView!
    @IBOutlet var searchBarView: UIView!
    @IBOutlet var searchIconImageView: UIImageView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var eventsTableView: UITableView!
    @IBOutlet var filterView: UIView!
    @IBOutlet var filterNumberView: UIView!
    @IBOutlet var filterNumberLabel: UILabel!
    @IBOutlet var noEventsImageView: UIImageView!
    @IBOutlet var noEventsLabel: UILabel!

    // MARK: Life Cycle Method

    override func awakeFromNib() {
        configureView()
    }

    // MARK: - Private Methods

    private func configureView() {
        setCornersAndBorders()
        setFonts()
        setText()
        setColors()
    }

    private func setCornersAndBorders() {
        calendarView.setCornerRadius(22)
        calendarView.setBorderColor(Color.borderGrey, andWidth: 1)
        searchBarView.setCornerRadius(10)
        filterView.setCornerRadius(25)
        filterNumberView.setCornerRadius(9)
    }

    private func setFonts() {
        eventsLabel.font = Font.sofiaBold(30)
        [dateLabel, noEventsLabel].forEach {
            $0.font = Font.sofiaBold(16)
        }
        searchTextField.font = Font.sofiaSemiBold(13)
        filterNumberLabel.font = Font.sofiaRegular(12)
    }

    private func setText() {
        eventsLabel.text = LocalizedKey.events.string
        searchTextField.placeholder = LocalizedKey.searchEvents.string
        noEventsLabel.text = LocalizedKey.noEventsAvailable.string
    }

    private func setColors() {
        backgroundColor = Color.backgroundPrimary
        calendarImageView.tintColor = Color.tintColor
        filterView.backgroundColor = Color.tintColor
        searchIconImageView.tintColor = Color.selectedDisabledColor
        filterNumberView.backgroundColor = Color.filterNumberBackground
    }
}
