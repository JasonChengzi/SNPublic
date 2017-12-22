//
//  SNConsole.swift
//  VTravel
//
//  Created by Jason Lee on 26/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import Foundation

typealias StandardDictionary = [String : Any]

protocol SNDevelopmentProtocol {
    static var environment: SN.ApplicationEnvironment { get }
    static var channel: String { get }
}
protocol SNMappableEntityProtocol {
    static func mapping(from dict: StandardDictionary) -> Self?
}
protocol SNCountableEnumProtocol {
    static var caseCount: Int { get } 
}
extension SNCountableEnumProtocol where Self: RawRepresentable, Self.RawValue == Int {
    internal static var caseCount: Int {
        var count = 0
        while let _ = Self(rawValue: count) {
            count += 1
        }
        return count
    }
}

class SN {
    enum ProjectEnvironment: String {
        case debug, release
    }
    enum ApplicationEnvironment: String {
        case development, pre_distribution, distribution 
    }
    static var environment: ProjectEnvironment = .debug
    
    static var localization = Localization.default
    static var networking = Networking.default
}
extension SN { class Closure {} }
extension SN.Closure {
    typealias empty = () -> ()
    typealias index = (Int) -> ()
    typealias finished = (Bool) -> ()
    typealias success = (Bool) -> ()
    typealias failed = (Bool) -> ()
}

fileprivate extension SN {
    static func debug(_ message: String) {
        guard SN.environment == .debug else { return }
        #if DEBUG
            print(message)
        #endif
    }
    static func debug<T>(_ value: T) {
        guard SN.environment == .debug else { return }
        #if DEBUG
            print(value)
        #endif
    }
}
extension SN {
    static func log(_ message: String) {
        debug("[\(String.init(fromDate: Date(), dateFormat: "yyyy-MM-dd HH:mm:ss"))]-[\(Date().timestamp)]\n\(message)\n")
    }
    static func log<T>(_ value: T) {
        debug("[\(String.init(fromDate: Date(), dateFormat: "yyyy-MM-dd HH:mm:ss"))]-[\(Date().timestamp)]\n\(value)\n")
    }
}
