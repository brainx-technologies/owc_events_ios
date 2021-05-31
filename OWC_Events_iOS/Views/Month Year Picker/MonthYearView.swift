//
//  MonthYearView.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/31/21.
//

import UIKit

class MonthYearView: UIView {
    // MARK: Outlets

    @IBOutlet var selectLabel: UILabel!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var pickerView: MonthYearPickerView!

    // MARK: Life Cycle Method

    override func awakeFromNib() {
        configureView()
    }

    // MARK: - Private Methods

    private func configureView() {
        setFonts()
        setText()
    }

    private func setFonts() {
        selectLabel.font = Font.sofiaSemiBold(16)
    }

    private func setText() {
        doneButton.setTitle(LocalizedKey.done.string, for: .normal)
        selectLabel.text = LocalizedKey.selectMonth.string
    }
}
