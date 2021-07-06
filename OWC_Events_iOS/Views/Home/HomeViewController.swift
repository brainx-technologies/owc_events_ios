//
//  HomeViewController.swift
//  zytrack_ios
//
//  Created by BrainX Technologies on 2/19/21.
//

import UIKit

enum HomeRouteType: RouteType {
    case Events(data: Any? = nil)
}

class HomeViewController: BaseViewController {
    // MARK: - Instance variables

    private var homeViewModel: HomeViewModel!

    // MARK: - Init Methods

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let router = HomeRouter(viewController: self)
        homeViewModel = HomeViewModel(router: router)
    }

    // MARK: - Override Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.LoadEventsViewController()
        UserDefaultsManager.typeThemeFilters.removeAll()
        UserDefaultsManager.locationFilters.removeAll()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
