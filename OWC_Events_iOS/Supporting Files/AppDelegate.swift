//
//  AppDelegate.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 5/24/21.
//

import IQKeyboardManagerSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupKeyboardManager()
        setRootViewController()
        return true
    }

    // MARK: - Private Methods

    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        IQKeyboardManager.shared.toolbarPreviousNextAllowedClasses = [UIStackView.self, UIView.self]
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }

    private func setRootViewController() {
        var vc: BaseViewController
        vc = UIViewController.instantiate(HomeViewController.self, fromStoryboard: .Main)
        let navRootController = UINavigationController(rootViewController: vc)
        navRootController.setNavigationBarHidden(true, animated: false)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navRootController
        window?.makeKeyAndVisible()
    }
}
