//
//  EventsTableViewCell.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/25/21.
//

import UIKit

class EventsTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet var containerView: UIView!
    @IBOutlet var dateStackView: UIStackView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dateDayLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var endDateDayLabel: UILabel!
    @IBOutlet var eventTitleLabel: UILabel!
    @IBOutlet var eventTimeLabel: UILabel!
    @IBOutlet var eventLocationLabel: UILabel!

    // MARK: - Override methods

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configureView()
    }

    // MARK: - Private Methods

    private func configureView() {
        setCorners()
        setBorders()
        setFonts()
        setText()
        setColors()
    }

    private func setCorners() {
        [containerView].forEach {
            $0.setCornerRadius(10)
        }
        dateStackView.setCornerRadius(10)
    }

    private func setBorders() {}

    private func setFonts() {
        [dateLabel, endDateLabel].forEach {
            $0?.font = Font.sofiaBold(22)
        }
        [dateDayLabel, endDateDayLabel].forEach {
            $0?.font = Font.sofiaRegular(13)
        }
        eventTitleLabel.font = Font.sofiaBold(20)
        [eventTimeLabel, eventLocationLabel].forEach {
            $0?.font = Font.sofiaRegular(14)
        }
    }

    private func setText() {}

    private func setColors() {
        dateStackView.backgroundColor = Color.tintColor
    }
}
