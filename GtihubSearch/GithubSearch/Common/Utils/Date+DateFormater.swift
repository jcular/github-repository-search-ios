//
//  Date+DateFormater.swift
//  GtihubSearch
//
//  Created by Jure Čular on 21/04/2020.
//  Copyright © 2020 Jure Čular. All rights reserved.
//

import Foundation

extension Date {
    private static var _displayDateFormatter: DateFormatter {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy, HH:mm"
            return dateFormatter
        }
    }
    
    private static var _isoDateFormatter: DateFormatter {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            return dateFormatter
        }
    }
    
    static func isoDate(fromString stringDate: String) -> Date? {
        return Self._isoDateFormatter.date(from: stringDate)
    }
    
    func displayDate() -> String {
        return Self._displayDateFormatter.string(from: self)
    }
    
}
