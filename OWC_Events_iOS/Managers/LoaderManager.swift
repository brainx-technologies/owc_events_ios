//
//  LoaderManager.swift
//  Level Up
//
//  Created by BrainX IOS 3 on 02/11/2020.
//

import Foundation
import MBProgressHUD

class LoaderManager {
    public static func show(_ view: UIView, message: String? = nil) {
        var viewFound = false
        repeat {
            viewFound = MBProgressHUD.hide(for: view, animated: true)
        } while viewFound

        let loader = MBProgressHUD.showAdded(to: view, animated: true)
        loader.mode = .indeterminate
        loader.bezelView.blurEffectStyle = .regular
        loader.bezelView.backgroundColor = UIColor.black
        if let message = message {
            loader.label.text = message
        }
        loader.contentColor = UIColor.white
    }

    public static func hide(_ view: UIView) {
        MBProgressHUD.hide(for: view, animated: true)
    }
}
