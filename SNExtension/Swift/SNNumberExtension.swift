//
//  NumberExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

typealias Byte = UInt8

extension Int {
    var float:      Float { return Float(self) }
    var double:     Double { return Double(self) }
    var cgfloat:    CGFloat { return CGFloat(self) }
    var byte:       Byte { return Byte(self) }
    var opposite:   Int { return -self }
    var absolute:   Int { return abs(self) }
}
extension Float {
    var int:        Int { return Int(self) }
    var double:     Double { return Double(self) }
    var cgfloat:    CGFloat { return CGFloat(self) }
    var opposite:   Float { return -self }
    var absolute:   Float { return abs(self) }
}
extension Double {
    var int:        Int { return Int(self) }
    var float:      Float { return Float(self) }
    var cgfloat:    CGFloat { return CGFloat(self) }
    var opposite:   Double { return -self }
    var absolute:   Double { return abs(self) }
}
