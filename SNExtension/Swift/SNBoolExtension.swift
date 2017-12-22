//
//  BoolExtension.swift
//  VTravel
//
//  Created by Jason Lee on 26/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import Foundation

extension Bool {
    var opposite: Bool { return !self }
    var right: Bool { return self == true }
    var negative: Bool {return self == false }
}
extension Bool {
    init(from stringValue: String?) {
        self = false
        if let stringValue = stringValue {
            self = (stringValue == "1")
        }
    }
    init(from intValue: Int?) {
        self = false
        if let intValue = intValue {
            self = (intValue == 1)
        }
    }
}

extension Bool {
    var int: Int { return self == true ? 1 : 0 }
    var string: String { return self == true ? "1" : "0" }
    func toInt() -> Int { return int }
    func toString() -> String { return string }
}

extension Bool {
    mutating func toggle() { self = !self }
}

extension Bool {
}
