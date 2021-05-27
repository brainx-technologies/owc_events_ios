//
//  EventsFilterTableViewCell.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/26/21.
//

import UIKit

class EventsFilterTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet var filterLabel: UILabel!
    @IBOutlet var filterImageView: UIImageView!
    @IBOutlet var lineView: UIView!

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
        setFonts()
        setColors()
    }

    private func setFonts() {
        filterLabel.font = Font.sofiaMedium(14)
    }

    private func setColors() {
        lineView.backgroundColor = Color.borderGrey
    }

    // MARK: - Public Methods

    func updateViewsWith(typeName: String) {
        filterLabel.text = typeName
    }

    func updateSelectedFilter(isSelected: Bool) {
        filterImageView.image = isSelected ? UIImage(named: Image.checkbox) : UIImage(named: Image.emptyCheckbox)
    }
}
