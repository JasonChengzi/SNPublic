//
//  StringExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import UIKit

// MARK: - Static & Variable Values
extension String {
    
    var intValue: Int? { return Int(self) }
    var floatValue: Float? { return Float(self) }
    var doubleValue: Double? { return Double(self) }
    var cgfloatValue: CGFloat? { return floatValue != nil ? CGFloat(floatValue!) : nil }
}
// MARK: - Initializers
extension String {
    init(fromDate date: Date, dateFormat format: String) {
        let dateFormatter = DateFormatter(dateFormat: format)
        self = dateFormatter.string(from: date)
    }
    init(from int: Int) { self = "\(int)" }
    init(from float: Float) { self = "\(float)" }
    init(from double: Double) { self = "\(double)" }
    init(from cgfloat: CGFloat) { self = "\(cgfloat)" }
    init(from bool: Bool) { self = "\(bool ? "true" : "false")" }
    
    static var empty: String { return "" }
}
// MARK: - Converters
extension String {
    func toNSString() -> NSString { return self as NSString }
    func toArray() -> [String] { return self.map { String($0) } }
    func toSecuredPhoneNumber() -> String {
        let convertedPhoneNumberPreffix = self[0, count == 8 ? 2 : 3]
        let convertedPhoneNumberSuffix = self[count - (count == 8 ? 3 : 4), count] 
        return "\(convertedPhoneNumberPreffix)\(count == 8 ? "***" : "****")\(convertedPhoneNumberSuffix)"
    }
}
// MARK: - Checking
extension String {
    var isAllNumber: Bool {
        let inverseSet = NSCharacterSet(charactersIn: "0123456789").inverted
        let components = self.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        return self == filtered
    }
}
// MARK: - Customed Methods
extension String {
    var reversed: String {
        var string = self
        string.reverse()
        return string
    }
    mutating func reverse() {
        let mappedCharacters = self.map{ return $0 }
        let reversed = mappedCharacters.reversed()
        self = String(reversed)
    }
}
extension String {
    subscript(start: Int, end: Int) -> String {
        get {
            guard end > start else { return "" }
            let theStartIndex = index(startIndex, offsetBy: start)
            let theEndIndex = index(startIndex, offsetBy: end)
            return String(self[theStartIndex..<theEndIndex])
        }
        set {
            guard end > start else { return }
            let theFirstEndIndex = index(startIndex, offsetBy: start)
            let theSecondStartIndex = index(startIndex, offsetBy: end)
            let startString = self[..<theFirstEndIndex]
            let endString = self[theSecondStartIndex..<endIndex]
            self = "\(startString)\(newValue)\(endString)"
        }
    }
}
extension String {
    func split(_ separator: Character) -> [String] {
        return self.split(separator: separator).map(String.init)
    }
    func split(at index: Int) -> [String] {
        guard index >= count else { return [self] }
        return [self[0, index], self[index, count - 1]]
    }
}
extension String {
    func size(withFont font: UIFont) -> CGSize {
        guard isEmpty.negative else { return .zero }
        return toNSString().size(withAttributes: [.font : font])
    }
    func height(withFont font: UIFont, width: CGFloat) -> CGFloat {
        guard isEmpty.negative else { return 0 }
        let size = self.size(withFont: font)
        return (size.width / width) * size.height
    }
}
