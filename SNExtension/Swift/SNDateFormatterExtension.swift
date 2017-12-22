//
//  DateFormatterExtension.swift
//  VTravel
//
//  Created by Jason Lee on 27/10/2017.
//  Copyright © 2017 Supernova Software. All rights reserved.
//

import Foundation

extension DateFormatter {
    public convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
}
