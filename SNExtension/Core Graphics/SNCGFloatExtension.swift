//
//  CGFloatExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

extension CGFloat {
    var int: Int { return Int(self) }
    var float: Float { return Float(self) }
    var double: Double { return Double(self) }
    
    var opposite: CGFloat { return -(self) }
    var absolute: CGFloat { return abs(self) }
}
