//
//  UIImageExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

extension UIImage {
    static func image(from color: UIColor, size: CGSize) -> UIImage? {
        var size = size
        if (size.width, size.height) == (0, 0) {
            size = CGSize(width: 1, height: 1)
        }
        UIGraphicsBeginImageContext(size)
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(origin: .zero, size: size))
        }
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
