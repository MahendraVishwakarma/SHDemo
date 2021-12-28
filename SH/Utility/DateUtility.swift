//
//  DateUtility.swift
//  Eroute
//
//  Created by Mahendra on 28/12/21.
//  Copyright © 2021 Mahendra. All rights reserved.
//

import Foundation

class DateUtility {

    static let shared = DateUtility()

    private init() { }
    
    func getDateText(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        return formatter.string(from: date)
    }
    
    func getTimeIn24HourFormat(from date: Date) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)

    }
    
    func getDate(from text: String) -> Date {
        guard !text.isEmpty else { return Date() }
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"

        if let date = formatter.date(from: text) {
            return date
        }
        return Date()
    }
    
    func getEventSectionDateText(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMMM d"
        return formatter.string(from: date)
    }
}

extension Date {
    func currentTimeMillis() -> Int64 {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
