//
//  UIDeviceExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

extension UIDevice {
    enum ModelType: String {
        case simulator, undefined
        
        init(identifier: String) {
            switch identifier {
            case "i386", "x86_64": self = .simulator
            default: self = .undefined
            }
        }
    }
    static var current: ModelType {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return ModelType(identifier: identifier)
    }
    static var isSimulator: Bool { return current == .simulator }
}
