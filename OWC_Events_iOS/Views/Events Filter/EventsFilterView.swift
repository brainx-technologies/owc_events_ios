//
//  EventsFilterView.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/26/21.
//

import UIKit

class EventsFilterView: UIView {
    // MARK: Outlets

    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var selectAllButton: UIButton!
    @IBOutlet var filterLabel: UILabel!
    @IBOutlet var filterTableView: UITableView!
    @IBOutlet var clearApplyContainerView: UIView!
    @IBOutlet var clearAllButton: UIButton!
    @IBOutlet var applyFilterButton: UIButton!

    // MARK: Life Cycle Method

    override func awakeFromNib() {
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
        [clearAllButton, applyFilterButton].forEach {
            $0?.setCornerRadius(10)
        }
    }

    private func setBorders() {
        clearAllButton.setBorderColor(Color.borderGrey, andWidth: 1)
    }

    private func setFonts() {
        filterLabel.font = Font.sofiaSemiBold(16)
        selectAllButton.titleLabel?.font = Font.sofiaSemiBold(17)
        [clearAllButton, applyFilterButton].forEach {
            $0?.titleLabel?.font = Font.sofiaRegular(17)
        }
    }

    private func setText() {
        filterLabel.text = LocalizedKey.filter.string
        selectAllButton.setTitle(LocalizedKey.selectAll.string, for: .normal)
        clearAllButton.setTitle(LocalizedKey.clearAll.string, for: .normal)
        applyFilterButton.setTitle(LocalizedKey.applyFilter.string, for: .normal)
    }

    private func setColors() {
        backgroundColor = Color.backgroundPrimary
        clearApplyContainerView.backgroundColor = Color.white
        clearAllButton.backgroundColor = Color.white
        clearAllButton.setTitleColor(Color.tintColor, for: .normal)
        selectAllButton.setTitleColor(Color.tintColor, for: .normal)
    }
}
