//
//  UIAlertController.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 6/4/21.
//

import Foundation
import UIKit

extension UIAlertController {
    /// Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let backgroundView = view.subviews.first,
           let groupView = backgroundView.subviews.first,
           let contentView = groupView.subviews.first
        {
            contentView.backgroundColor = color
        }
    }

    /// Set title font and title color of UIAlertController
    func setTitle(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title) // 1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font: titleFont], // 2
                                          range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor: titleColor], // 3
                                          range: NSMakeRange(0, title.utf8.count))
        }
        setValue(attributeString, forKey: "attributedTitle") // 4
    }

    /// Set message font and message color of UIAlertController
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let title = message else {
            return
        }
        let attributedString = NSMutableAttributedString(string: title)
        if let titleFont = font {
            attributedString.addAttributes([NSAttributedString.Key.font: titleFont], range: NSMakeRange(0, title.utf8.count))
        }
        if let titleColor = color {
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor: titleColor], range: NSMakeRange(0, title.utf8.count))
        }
        setValue(attributedString, forKey: "attributedMessage") // 4
    }

    /// Set tint color of UIAlertController
    func setTint(color: UIColor) {
        view.tintColor = color
    }
}
