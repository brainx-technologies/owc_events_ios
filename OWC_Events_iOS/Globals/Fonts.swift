//
//  Fonts.swift
//  ZyTrack
//
//  Created by BrainX Technologies on 2/19/21.
//

import Foundation
import UIKit

enum Font {
    static func sofiaBlack(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "SofiaPro-Black", size: size)
    }

    static func sofiaBold(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "SofiaPro-Bold", size: size)
    }

    static func sofiaLight(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "SofiaPro-Light", size: size)
    }

    static func sofiaMedium(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "SofiaPro-Medium", size: size)
    }

    static func sofiaRegular(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "SofiaPro", size: size)
    }

    static func sofiaSemiBold(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "SofiaPro-SemiBold", size: size)
    }

    static func sofiaUltraLight(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "SofiaPro-UltraLight", size: size)
    }

    static func muliRegular(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Muli", size: size)
    }

    static func muliBold(_ size: CGFloat) -> UIFont? {
        return UIFont(name: "Muli-Bold", size: size)
    }
}
