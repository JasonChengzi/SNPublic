//
//  UIStoryboardExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

extension UIStoryboard {
    convenience init(fileName: String) {
        self.init(name: fileName, bundle: nil)
    }
    static func instantiateViewController<T>(fromStoryboard named: String, type: T.Type) -> T? {
        let storyboard = UIStoryboard(fileName: named)
        return storyboard.instantiateViewController(withIdentifier: String(describing: type)) as? T
    }
}
