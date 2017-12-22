//
//  UIViewExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    @IBInspectable var borderColor: UIColor? {
        get { return layer.borderColor != nil ? UIColor(cgColor: layer.borderColor!) : nil }
        set {
            layer.borderColor = newValue?.cgColor
            if let newValue = newValue, newValue != .clear, borderWidth < 1 {
                layer.borderWidth = 1
            }
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
}

extension UIView {
    static var nibName: String { return "\(self)".components(separatedBy: ".").first ?? "" }
    static var nib: UINib? { return Bundle.main.path(forResource: nibName, ofType: "nib") != nil ? UINib(nibName: nibName, bundle: nil) : nil }
    @discardableResult
    static func instanceFromNib<T: UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T? {
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            name = nibName
        }
        guard let nibViews = Bundle.main.loadNibNamed(name, owner: nil, options: nil) else { return nil }
        for tempView in nibViews {
            if let instance = tempView as? T { return instance }
        }
        return nil
    }
    @discardableResult
    static func instanceFromNib(nibNameOrNil: String? = nil) -> Self? {
        return instanceFromNib(nibNameOrNil: nibNameOrNil, type: self)
    }
}
