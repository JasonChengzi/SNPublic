//
//  ArrayExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import Foundation

extension Array {
    var isEmpty: Bool { return count <= 0 }
    var hasElement: Bool { return isEmpty.negative }
    
    var lastIndex: Int { return isEmpty ? 0 : count - 1 }
}

extension Array {
    subscript(start: Int, end: Int) -> Array {
        get {
            guard end > start else { return Array() }
            return Array(self[start..<end])
        }
        set {
            guard end > start else { return }
            let theFirstEndIndex = index(startIndex, offsetBy: start)
            let theSecondStartIndex = index(startIndex, offsetBy: end)
            let startArray = self[..<theFirstEndIndex]
            let endArray = self[theSecondStartIndex..<endIndex]
            self = startArray + newValue + endArray
        }
    }
}

extension Array {
    mutating func remove<T>(_ element: T) where T: Equatable {
        self = self.filter { $0 as? T != element }
    }
}

func +<T>(lhs: [T], rhs: [T]) -> [T] {
    var result = [T]()
    result.append(contentsOf: lhs)
    result.append(contentsOf: rhs)
    return result
}
func +=<T>(lhs: inout [T], rhs: [T]) {
    lhs.append(contentsOf: rhs)
}
