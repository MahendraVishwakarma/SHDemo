//
//  DateUtility.swift
//  Eroute
//
//  Created by bhavesh on 25/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import Foundation

class DateUtility {

    static let shared = DateUtility()

    private init() { }

    func getTimeIn12HourFormat(from date: Date) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter.string(from: date)

    }

    func getDateFrom12HourTime(from text: String) -> Date {
        guard !text.isEmpty else { return Date() }

        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy "

        let dateInitialText = formatter.string(from: Date())
        let completeDateText = dateInitialText + " " + text

        formatter.dateFormat = "MM-dd-yyyy hh:mm a"

        if let date = formatter.date(from: completeDateText) {
            return date
        }

        return Date()
    }

    func getDateTimeText(from date: Date) -> String {

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy hh:mm a"

        return formatter.string(from: date)
    }

    func getDateFromDateTimeText(from text: String) -> Date {
        guard !text.isEmpty else { return Date() }

        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy hh:mm a"

        if let date = formatter.date(from: text) {
            return date
        }

        return Date()
    }

    func getOnlyDateText(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: date)
    }
}
