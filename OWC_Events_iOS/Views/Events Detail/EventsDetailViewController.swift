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
        eventsDetailView.aboutMessageLabel.addTapAction(#selector(handleTextViewExpandCollapse), target: self)
        eventsDetailView.aboutMessageHeightConstraint.constant = 100
        eventsDetailView.collapseView()
        eventsDetailView.dateContainerView.backgroundColor = selectedDate.getWeekDay().getColor()
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
        eventsDetailView.handleAboutSeeMore()
    }
}
