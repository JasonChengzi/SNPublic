//
//  NSObjectExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import Foundation

extension NSObject {
    static var className: String { return String(describing: self) }
    var className: String { return String(describing: self) }
}
