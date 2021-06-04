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
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var startDateDayLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var endDateDayLabel: UILabel!
    @IBOutlet var eventTitleLabel: UILabel!
    @IBOutlet var eventTimeLabel: UILabel!
    @IBOutlet var eventLocationLabel: UILabel!
    @IBOutlet var startDateView: UIView!
    @IBOutlet var separatorView: UIView!
    @IBOutlet var endDateView: UIView!

    // MARK: - Override methods

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        configureView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 0))
    }

    // MARK: - Private Methods

    private func configureView() {
        setCorners()
        setFonts()
        setColors()
    }

    private func setCorners() {
        [self, containerView].forEach {
            $0.setCornerRadius(10)
        }
        dateStackView.setCornerRadius(10)
    }

    private func setFonts() {
        [startDateLabel, endDateLabel].forEach {
            $0?.font = Font.muliBold(18)
        }
        [startDateDayLabel, endDateDayLabel].forEach {
            $0?.font = Font.muliRegular(12)
        }
        eventTitleLabel.font = Font.sofiaBold(20)
        [eventTimeLabel, eventLocationLabel].forEach {
            $0?.font = Font.sofiaRegular(14)
        }
    }

    private func setColors() {
        dateStackView.backgroundColor = Color.tintColor
    }

    // MARK: - PUblic Methods

    func updateWith(event: OWCEvent) {
        eventTitleLabel.text = event.title
        if event.startDate?.get(.day) == event.endDate?.get(.day),
           event.startDate?.get(.month) == event.endDate?.get(.month),
           event.startDate?.get(.year) == event.endDate?.get(.year)
        {
            separatorView.isHidden = true
            endDateView.isHidden = true
        } else {
            separatorView.isHidden = false
            endDateView.isHidden = false
        }
        startDateLabel.text = Date.dayNumberFormator.string(from: event.startDate ?? Date())
        startDateDayLabel.text = Date.dayNameFormator.string(from: event.startDate ?? Date())
        endDateLabel.text = Date.dayNumberFormator.string(from: event.endDate ?? Date())
        endDateDayLabel.text = Date.dayNameFormator.string(from: event.endDate ?? Date())
        dateStackView.backgroundColor = event.startDate?.getWeekDay().getColor()
    }
}
