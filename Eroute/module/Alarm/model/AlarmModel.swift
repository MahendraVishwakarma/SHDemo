//
//  AlarmModel.swift
//  Eroute
//
//  Created by bhavesh on 25/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import Foundation

struct AlarmModel {
    var label: String
    var dateText: String
    var isSnooze: Bool
    var id: UUID
    var repeatValue: Int
}

extension AlarmModel {
    init(from alarm: Alarm) {
        self.label = alarm.label ?? ""
        self.dateText = alarm.dateText ?? ""
        self.isSnooze = alarm.isSnooze
        self.id = alarm.id ?? UUID()
        self.repeatValue = Int(alarm.repeatValue)
    }
}
