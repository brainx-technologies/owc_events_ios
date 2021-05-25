//
//  BaseViewController.swift
//  Level Up
//
//  Created by BrainX IOS 3 on 02/11/2020.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        disableDarkMode()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        if #available(iOS 13.0, *) {
            return .lightContent
        } else {
            return .default
        }
    }

    func showLoader(_ show: Bool) {
        show ? LoaderManager.show(view) : LoaderManager.hide(view)
    }

    func showAlertView(message: String) {
        showAlertView(message: message, title: LocalizedKey.appName.string)
    }

    func showAlertView(message: String, title: String, doneButtonTitle: String, doneButtonCompletion: ((UIAlertAction) -> Void)?) {
        showAlertView(message: message, title: title, doneButtonTitle: doneButtonTitle, doneButtonCompletion: doneButtonCompletion, cancelButtonTitle: nil, cancelButtonCompletion: nil)
    }

    func showAlertView(message: String, title: String, doneButtonTitle: String = LocalizedKey.ok.string.uppercased(), doneButtonCompletion: ((UIAlertAction) -> Void)? = nil, cancelButtonTitle: String? = nil, cancelButtonCompletion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: doneButtonTitle, style: .default, handler: doneButtonCompletion)
        if let cancelTitle = cancelButtonTitle {
            let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: cancelButtonCompletion)
            alertController.addAction(cancelAction)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    func showAlertView(message: String, title: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: LocalizedKey.ok.string.uppercased(), style: UIAlertAction.Style.default) { (_: UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    private func disableDarkMode() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
    }
}
