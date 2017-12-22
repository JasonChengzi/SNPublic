//
//  UIWindowExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

extension UIWindow {
    static var current: UIWindow? {
        let application = UIApplication.shared
        guard application.keyWindow == nil else { return application.keyWindow }
        guard application.windows.last == nil else { return application.windows.last }
        guard application.delegate?.window == nil else { return (application.delegate?.window)! }
        return nil
    }
}
