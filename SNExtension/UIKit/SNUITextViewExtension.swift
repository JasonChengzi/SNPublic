//
//  UITextViewExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

extension UITextView {
    var length: Int { return text != nil ? text!.count : 0 }
    var isEmpty: Bool { return length <= 0 }
}
extension UITextView {
    func clean() { text = "" }
    func append(text: String, newLine: Bool = false) {
        if self.text == nil { self.text = "" }
        self.text = self.text + (newLine ? "\n" : "") + text
    }
}
