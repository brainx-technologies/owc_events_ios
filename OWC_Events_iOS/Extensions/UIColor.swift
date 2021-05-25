//
//  UIColor.swift
//  ZyTrack
//
//  Created by BrainX Technologies on 2/17/21.
//

import Foundation
import UIKit

public extension UIColor {
    convenience init(_ value: Int) {
        let r = CGFloat(value >> 16 & 0xFF) / 255.0
        let g = CGFloat(value >> 8 & 0xFF) / 255.0
        let b = CGFloat(value & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
