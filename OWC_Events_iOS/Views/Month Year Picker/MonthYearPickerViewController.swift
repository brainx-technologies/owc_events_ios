//
//  MonthYearPickerViewController.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/31/21.
//

import UIKit

protocol UpdateMonthYearProtocol {
    func updatedMonthAndYear(date: Date)
}

class MonthYearPickerViewController: BaseViewController {
    // MARK: Outlets

    @IBOutlet var monthYearView: MonthYearView!

    // MARK: - Instance Variables

    var viewModel: MonthYearPickerViewModel!
    var selectedMonth: Int = 0
    var selectedYear: Int = 0
    var monthYearDelegate: UpdateMonthYearProtocol?

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        let router = MonthYearRouter(controller: self)
        viewModel = MonthYearPickerViewModel(router: router)
        view.isUserInteractionEnabled = true
        view.addTapAction(#selector(handleCloseViewController), target: self)
        handleDatePicker()
    }

    // MARK: - Private Methods

    private func handleDatePicker() {
        monthYearView.pickerView.month = selectedMonth
        monthYearView.pickerView.year = selectedYear
        monthYearView.pickerView.onDateSelected = { (month: Int, year: Int) in
            self.selectedMonth = month
            self.selectedYear = year
        }
    }

    // MARK: - Action Methods

    @IBAction
    func handleDoneButton(_: Any) {
        var dateComponents: DateComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
        dateComponents.month = selectedMonth
        dateComponents.year = selectedYear
        let date = Calendar.current.date(from: dateComponents) ?? Date()
        monthYearDelegate?.updatedMonthAndYear(date: date)
        viewModel.dismisViewController()
    }

    @objc
    func handleCloseViewController() {
        viewModel.dismisViewController()
    }
}

extension MonthYearPickerViewController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(20)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
