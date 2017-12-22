//
//  UITableViewExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T>(withIdentifier identifier: String, _ initial: (() -> T)? = nil) -> T where T: UITableViewCell {
        return (dequeueReusableCell(withIdentifier: identifier) as? T ?? initial?()) ?? T(style: .default, reuseIdentifier: identifier)
    }
}
