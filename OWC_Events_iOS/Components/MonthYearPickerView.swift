//
//  MonthYearPickerView.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/31/21.
//

import Foundation
import UIKit

class MonthYearPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK: - Instance Variables

    let noOfSection = 2
    var months = [String]()
    var years = [Int]()

    var month = Calendar.current.component(.month, from: Date()) {
        didSet {
            selectRow(month - 1, inComponent: 0, animated: false)
        }
    }

    var year = Calendar.current.component(.year, from: Date()) {
        didSet {
            if let firstYearIndex = years.firstIndex(of: year) {
                selectRow(firstYearIndex, inComponent: 1, animated: true)
            }
        }
    }

    var onDateSelected: ((_ month: Int, _ year: Int) -> Void)?

    // MARK: - Override Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }

    // MARK: - Public Methods

    func commonSetup() {
        // population years
        var years: [Int] = []
        if years.count == 0 {
            var year = Calendar(identifier: .gregorian).component(.year, from: Date())
            for _ in 1 ... 15 {
                years.append(year)
                year += 1
            }
        }
        self.years = years

        // population months with localized names
        var months: [String] = []
        var month = 0
        for _ in 1 ... 12 {
            months.append(DateFormatter().monthSymbols[month].capitalized)
            month += 1
        }
        self.months = months

        delegate = self
        dataSource = self

        let currentMonth = Calendar(identifier: .gregorian).component(.month, from: Date())
        selectRow(currentMonth - 1, inComponent: 0, animated: false)
    }

    // MARK: UIPicker Delegate / Data Source

    func numberOfComponents(in _: UIPickerView) -> Int {
        return noOfSection
    }

    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return months[row]
        case 1:
            return "\(years[row])"
        default:
            return nil
        }
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return months.count
        case 1:
            return years.count
        default:
            return 0
        }
    }

    func pickerView(_: UIPickerView, didSelectRow _: Int, inComponent _: Int) {
        let month = selectedRow(inComponent: 0) + 1
        let year = years[selectedRow(inComponent: 1)]
        if let block = onDateSelected {
            block(month, year)
        }

        self.month = month
        self.year = year
    }
}
