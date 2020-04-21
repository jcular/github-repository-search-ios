//
//  Date+DateFormater.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import Foundation

extension Date {
    private static var _dateFormatter: DateFormatter {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter
        }
    }
    
    static func isoDate(fromString stringDate: String) -> Date? {
        return Self._dateFormatter.date(from: stringDate)
    }
}
