//
//  UIApplicationExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

extension UIApplication {
    var isActive: Bool { return applicationState != .background } 
}
