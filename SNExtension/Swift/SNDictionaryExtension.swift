//
//  DictionaryExtension.swift
//  VTravel
//
//  Created by Jason Lee on 26/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import Foundation

extension Dictionary {
    func toNSDictionary() -> NSDictionary { return (self as NSDictionary) }
}

extension Dictionary {
    func string(for key: String) -> String? { return toNSDictionary().string(for: key) }
    func int(for key: String) -> Int? { return toNSDictionary().int(for: key) }
    func float(for key: String) -> Float? { return toNSDictionary().float(for: key) }
    func double(for key: String) -> Double? { return toNSDictionary().double(for: key) }
    func bool(for key: String) -> Bool? { return toNSDictionary().bool(for: key) }
    func dictionary<K, V>(for key: String) -> Dictionary<K, V>? {
        return toNSDictionary().value(forKey: key) as? [K : V]
    }
    func standardDictionary(for key: String) -> StandardDictionary? {
        return toNSDictionary().value(forKey: key) as? StandardDictionary
    }
    func array<T>(for key: String) -> [T]? {
        return toNSDictionary().value(forKey: "key") as? [T]
    }
}

extension Dictionary {
    mutating func merge<K, V>(with dictionarys: Dictionary<K, V>...) {
        for dictionary in dictionarys {
            for (key, value) in dictionary {
                updateValue(value as! Value, forKey: key as! Key)
            }
        }
    }
}

func + <K, V>(lhs: [K : V], rhs: [K : V]) -> [K : V] {
    var result = [K : V]()
    for (key, value) in lhs {
        result[key] = value
    }
    for (key, value) in rhs {
        result[key] = value
    }
    return result
}
func += <K, V>(lhs: inout [K : V], rhs: [K : V]) {
    for (k, v) in rhs {
        lhs[k] = v
    }
}
