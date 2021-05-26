//
//  EventsDetailView.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/24/21.
//

import UIKit

class EventsDetailView: UIView {
    // MARK: Outlets

    @IBOutlet var eventDetailLabel: UILabel!
    @IBOutlet var topContainerView: UIView!
    @IBOutlet var backButton: UIButton!

    // MARK: Life Cycle Method

    override func awakeFromNib() {
        configureView()
    }

    // MARK: - Private Methods

    private func configureView() {
        setBorders()
        setFonts()
        setText()
        setColors()
    }

    private func setBorders() {}

    private func setFonts() {
        eventDetailLabel.font = Font.sofiaSemiBold(16)
    }

    private func setText() {
        eventDetailLabel.text = LocalizedKey.eventDetails.string
    }

    private func setColors() {}
}
