//
//  UIButtonExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

extension UIButton {
    var normalTitle: String? {
        get { return title(for: .normal) }
        set (newValue) { setTitle(newValue, for: .normal) }
    }
    var highlightedTitle: String? {
        get { return title(for: .highlighted) }
        set (newValue) { setTitle(newValue, for: .highlighted) }
    }
    
    var normalTitleColor: UIColor? {
        get { return titleColor(for: .normal) }
        set (newColor) { setTitleColor(newColor, for: .normal) }
    }
    var highlightedTitleColor: UIColor? {
        get { return titleColor(for: .highlighted) }
        set (newColor) { setTitleColor(newColor, for: .highlighted) }
    }
    var selectedTitleColor: UIColor?{
        get { return titleColor(for: .selected) }
        set (newColor) { setTitleColor(newColor, for: .selected) }
    }
    
    var titleFont: UIFont? {
        get { return titleLabel?.font }
        set (newFont) { titleLabel?.font = newFont }
    }
    
    var normalImage: UIImage?{
        get {return image(for: .normal)}
        set (newValue) { setImage(newValue, for: .normal) }
    }
    var selectedImage: UIImage?{
        get {return image(for: .selected)}
        set (newValue) { setImage(newValue, for: .selected) }
    }
}
