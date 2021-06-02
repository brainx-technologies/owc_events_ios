//
//  EventsDetailViewController.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/24/21.
//

import UIKit

class EventsDetailViewController: BaseViewController {
    // MARK: Outlets

    @IBOutlet var eventsDetailView: EventsDetailView!

    // MARK: - Instance Variables

    var viewModel: EventsDetailViewModel!
    var selectedDate = Date()

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        let router = EventsDetailRouter(controller: self)
        viewModel = EventsDetailViewModel(router: router)
        eventsDetailView.aboutMessageTextView.addTapAction(#selector(handleTextViewExpandCollapse), target: self)
    }

    // MARK: - Action Methods

    @IBAction
    func handleBackButton(_: Any) {
        viewModel.backButtonPressed()
    }

    @IBAction
    func handleViewMapButton(_: Any) {
        viewModel.viewInMap()
    }

    @IBAction
    func handleAddToCalendarButton(_: Any) {
        viewModel.addToCalendar()
    }

    @objc
    func handleTextViewExpandCollapse() {
        let fixedWidth = eventsDetailView.aboutMessageTextView.frame.size.width
        if eventsDetailView.aboutMessageHeightConstraint.constant == 64 {
            let newSize = eventsDetailView.aboutMessageTextView.sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude)).height
            eventsDetailView.aboutMessageHeightConstraint.constant = newSize
        } else {
            eventsDetailView.aboutMessageHeightConstraint.constant = 64
            eventsDetailView.aboutMessageTextView.textContainer.lineBreakMode = .byTruncatingTail
        }
    }
}
