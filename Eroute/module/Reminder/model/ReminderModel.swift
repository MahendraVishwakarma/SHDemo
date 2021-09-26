//
//  ReminderModel.swift
//  Eroute
//
//  Created by bhavesh on 26/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import Foundation

struct ReminderModel {
    var id: UUID
    var label: String
    var note: String
    var dateTimeText: String
    var isCompleted: Bool
}

extension ReminderModel {

    init(from reminder: Reminder) {
        self.id = reminder.id ?? UUID()
        self.label = reminder.label ?? ""
        self.note = reminder.note ?? ""
        self.dateTimeText = reminder.dateTimeText ?? ""
        self.isCompleted = reminder.isCompleted
    }
}

