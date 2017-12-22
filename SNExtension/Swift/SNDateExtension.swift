//
//  DateExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import Foundation

extension Date {
    var timestamp: TimeInterval { return timeIntervalSince1970 }
}
extension Date {
    init?(fromString dateString: String, dateFormat: String) {
        let dateFormatter = DateFormatter(dateFormat: dateFormat)
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        self = date
    }
}
extension Date {
    func dateComponents(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    } 
}
extension Date {
    func offset(from date: Date, component: Calendar.Component) -> Int? {
        let dateComponents = Calendar.current.dateComponents([component], from: date, to: self)
        return dateComponents.value(for: component)
    }
    func years(from date: Date) -> Int? {
        return offset(from: date, component: .year)
    }
    func months(from date: Date) -> Int? {
        return offset(from: date, component: .month)
    }
    func days(from date: Date) -> Int? {
        return offset(from: date, component: .day)
    }
    func hours(from date: Date) -> Int? {
        return offset(from: date, component: .hour)
    }
    func minutes(from date: Date) -> Int? {
        return offset(from: date, component: .minute)
    }
    func seconds(from date: Date) -> Int? {
        return offset(from: date, component: .second)
    }
    func weeks(from date: Date) -> Int? {
        return offset(from: date, component: .weekOfYear)
    }
}
extension Date {
    func toString(withDateFormat format: String) -> String {
        let dateFormatter = DateFormatter(dateFormat: format)
        return dateFormatter.string(from: self)
    }
}
