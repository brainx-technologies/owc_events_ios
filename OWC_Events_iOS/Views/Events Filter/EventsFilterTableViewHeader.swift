//
//  EventsFilterTableViewHeader.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/26/21.
//

import SnapKit
import UIKit

class EventsFilterTableViewHeader: UIView {
    // MARK: - Instance Variables

    let totalTitleLabel = UILabel()
    let totalValueLabel = UILabel()
    let hStackView = UIStackView()

    // MARK: - Override Methods

    override func layoutSubviews() {
        super.layoutSubviews()
        setCornerRadius(10, forCorners: [.layerMinXMinYCorner, .layerMaxXMinYCorner], andClipContent: true)
        backgroundColor = Color.white
        setupViews()
    }

    // MARK: - Private Methods

    private func setupViews() {
        [totalTitleLabel, totalValueLabel].forEach {
            $0.textColor = Color.black
            $0.font = Font.sofiaBold(18)
        }
        totalValueLabel.textAlignment = .right
        hStackView.distribution = .fillEqually
        hStackView.axis = .horizontal
        hStackView.alignment = .center
        hStackView.addArrangedSubview(totalTitleLabel)
        hStackView.addArrangedSubview(totalValueLabel)
        addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(8)
            make.trailing.equalTo(self).offset(-16)
            make.centerY.equalTo(self)
        }
    }

    // MARK: - Public Methods

    func set(title: String) {
        totalTitleLabel.text = title
    }
}
