//
//  EventsDetailView.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/24/21.
//

// import ReadMoreTextView
import UIKit

class EventsDetailView: UIView {
    // MARK: Outlets

    @IBOutlet var eventDetailLabel: UILabel!
    @IBOutlet var topContainerView: UIView!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var dateContainerView: UIView!
    @IBOutlet var timeLocationContainerView: UIView!
    @IBOutlet var timeInnerLocationContainerView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var aboutLabel: UILabel!
    @IBOutlet var aboutMessageTextView: ReadMoreTextView!
    @IBOutlet var aboutMessageHeightConstraint: NSLayoutConstraint!
    @IBOutlet var locationTitleLabel: UILabel!
    @IBOutlet var mapButton: UIButton!
    @IBOutlet var mapImageView: UIImageView!
    @IBOutlet var locationValueContainerView: UIView!
    @IBOutlet var locationValueLabel: UILabel!
    @IBOutlet var addToCalendarButton: UIButton!
    @IBOutlet var scrollViewHeightConstraint: NSLayoutConstraint!

    // MARK: Instance Variables

    let collapsedHeight: CGFloat = 72
    var fullSizeTextHeight: CGFloat = 0
    var messageText: String = LocalizedKey.empty.string
    var isCollapased: Bool = true

    // MARK: Life Cycle Method

    override func awakeFromNib() {
        configureView()
    }

    // MARK: - Private Methods

    private func configureView() {
        setBorders()
        setCorners()
        setFonts()
        setText()
        setColors()
        setupViews()
    }

    private func setBorders() {
        timeLocationContainerView.addShadow(color: Color.shadowColor, alpha: 0.25, x: 0, y: 2, blur: 10)
        mapButton.addShadow(color: Color.black, alpha: 0.1, x: 0, y: 2, blur: 6)
        [mapButton, addToCalendarButton].forEach {
            $0?.setBorderColor(Color.borderGrey, andWidth: 1)
        }
    }

    private func setCorners() {
        [dateContainerView, timeLocationContainerView, timeInnerLocationContainerView, addToCalendarButton].forEach {
            $0?.setCornerRadius(10)
        }
        locationValueContainerView.setCornerRadius(8)
        mapButton.setCornerRadius(5)
    }

    private func setFonts() {
        titleLabel.font = Font.sofiaBold(26)
        eventDetailLabel.font = Font.sofiaSemiBold(16)
        [aboutLabel, locationTitleLabel].forEach {
            $0?.font = Font.sofiaBold(16)
        }
        [timeLabel, locationLabel, dateLabel, locationValueLabel].forEach {
            $0?.font = Font.sofiaRegular(14)
        }
        aboutMessageTextView.font = Font.sofiaRegular(14)
        addToCalendarButton.titleLabel?.font = Font.sofiaRegular(17)
    }

    private func setText() {
        eventDetailLabel.text = LocalizedKey.eventDetails.string
        aboutLabel.text = LocalizedKey.aboutThisEvent.string
        locationTitleLabel.text = LocalizedKey.eventLocation.string
        mapButton.setTitle(LocalizedKey.viewMap.string, for: .normal)
        addToCalendarButton.setTitle(LocalizedKey.addToCalendar.string, for: .normal)
    }

    private func setColors() {
        backgroundColor = Color.white
        dateContainerView.backgroundColor = Color.dateContainerColor
    }

    private func setupViews() {
        locationValueLabel.text = "400 margrate st, Marelebone, London" // will replace with actual data after api implementation
        messageText = "We had to develop app within 6 months. It’s quite short time but we managed it out. You can check how it works by downloading app on Appstore and Google. We had to develop app within 6 months. It’s quite short time but we managed it out. You can check how it works by downloading app on Appstore and Google. We had to develop app within 6 months. It’s quite short time but we managed it out. You can check how it works by downloading app on Appstore and Google." // will replace with actual data after api implementation
        aboutMessageTextView.text = messageText
        aboutMessageTextView.maximumNumberOfLines = 4
        aboutMessageTextView.shouldTrim = true
        isCollapased = true
        let fixedWidth = aboutMessageTextView.bounds.size.width
        fullSizeTextHeight = aboutMessageTextView.sizeThatFits(CGSize(width: fixedWidth, height: .greatestFiniteMagnitude)).height
        scrollViewHeightConstraint.constant = fullSizeTextHeight / 2
    }

    // MARK: - Public Methods

    func handleAboutSeeMore() {
        if isCollapased {
            isCollapased = false
            aboutMessageHeightConstraint.constant = fullSizeTextHeight
            UIView.animate(withDuration: 0.15) {
                self.layoutIfNeeded()
            }
        } else {
            isCollapased = true
            aboutMessageHeightConstraint.constant = collapsedHeight
            UIView.animate(withDuration: 0.15) {
                self.layoutIfNeeded()
            }
        }
    }
}
