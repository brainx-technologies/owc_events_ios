//
//  UITableViewCell.swift
//  Tespo Health
//
//  Created by BrainX Technologies on 27/04/2020.
//  Copyright © 2020 BrainX Technologies. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    static var nibName: String {
        return String(describing: self)
    }
}
