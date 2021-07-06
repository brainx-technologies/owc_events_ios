//
//  MonthYearPickerViewModel.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/31/21.
//

import Foundation

class MonthYearPickerViewModel {
    // MARK: - Instance Properties

    private var router: MonthYearRouter

    // MARK: - Init Methods

    required init(router: MonthYearRouter) {
        self.router = router
    }

    // MARK: - Public Methods

    func dismisViewController() {
        router.dismissVC(navigationType: .overlay, animated: true, completion: nil)
    }
}
