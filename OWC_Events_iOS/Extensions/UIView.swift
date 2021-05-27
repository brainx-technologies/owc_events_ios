//
//  UIView.swift
//  ZyTrack
//
//  Created by BrainX Technologies on 2/18/21.
//

import UIKit

enum Border: String {
    case top = "topBorder"
    case bottom = "bottomBorder"
    case left = "leftBorder"
    case right = "rightBorder"
}

extension UIView {
    @objc var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }

    func setCornerRadius(_ r: CGFloat, forCorners corners: CACornerMask, andClipContent clip: Bool = false) {
        layer.maskedCorners = corners
        setCornerRadius(r, andClipContent: clip)
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
//        layer.mask = mask
    }

    @discardableResult
    func loadFromNib<T: UIView>() -> T? {
        let bundle = Bundle(for: type(of: self))
        let loadedView = bundle.loadNibNamed(String(describing: type(of: self)),
                                             owner: self,
                                             options: nil)?.first
        guard let contentView = loadedView as? T else {
            return nil
        }
        return contentView
    }

    @discardableResult
    func fromNib<T: UIView>() -> T? {
        guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
            return nil
        }
        addSubview(contentView)
        return contentView
    }

    func setBorderColor(_ color: UIColor, andWidth width: CGFloat = 1.0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func setCornerRadius(_ r: CGFloat, andClipContent clip: Bool = false) {
        layer.cornerRadius = r
        layer.masksToBounds = clip
    }

    func addBorder(_ border: Border, withColor color: UIColor, andWidth width: CGFloat) {
        let borderLayer = CALayer()
        borderLayer.name = border.rawValue
        borderLayer.backgroundColor = color.cgColor
        switch border {
        case .top:
            borderLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .bottom:
            borderLayer.frame = CGRect(x: 0, y: frame.size.height - width, width: frame.size.width, height: width)
        case .left:
            borderLayer.frame = CGRect(x: 0, y: 0, width: width, height: frame.size.height)
        case .right:
            borderLayer.frame = CGRect(x: frame.size.width - width, y: 0, width: width, height: frame.size.height)
        }

        layer.addSublayer(borderLayer)
    }

    func removeBorder(_ border: Border) {
        for layer in layer.sublayers ?? [] {
            if layer.name == border.rawValue {
                layer.removeFromSuperlayer()
            }
        }
    }

    func addTapAction(_ action: Selector, target: Any? = nil) {
        let tapGesture = UITapGestureRecognizer(target: target ?? self, action: action)
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
    }

    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView]
    {
        var borders = [UIView]()

        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border])
            })
            borders.append(border)

            return border
        }

        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }

        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }

        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        return borders
    }

    func addLeftCorner() {
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        let path = UIBezierPath()

        path.move(to: CGPoint(x: 10, y: 0))
        path.addArc(withCenter: CGPoint(x: 10, y: 10), radius: 10, startAngle: CGFloat.pi * 3.0 / 2.0, endAngle: CGFloat.pi, clockwise: false)

        cornerLayer.strokeColor = UIColor.red.cgColor
        cornerLayer.fillColor = UIColor.clear.cgColor
        cornerLayer.lineWidth = 1
        cornerLayer.path = path.cgPath

        layer.addSublayer(cornerLayer)
    }

    func addShadow(color: UIColor = Color.black,
                   alpha: Float = 1,
                   x: CGFloat = 0,
                   y: CGFloat = 2,
                   blur: CGFloat = 2)
    {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowOpacity = alpha
        layer.shadowRadius = blur
        layer.masksToBounds = false
    }
}
