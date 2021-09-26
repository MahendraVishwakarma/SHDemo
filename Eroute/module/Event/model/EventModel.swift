//
//  EventModel.swift
//  Eroute
//
//  Created by bhavesh on 26/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import Foundation

struct EventModel {
    var id: UUID
    var name: String
    var dateText: String
    var startTimeText: String
    var endTimeText: String
    var eventDescription: String
}

extension EventModel {
    init(from event: Event) {
        self.id = event.id ?? UUID()
        self.name = event.name ?? ""
        self.dateText = event.dateText ?? ""
        self.startTimeText = event.startTimeText ?? ""
        self.endTimeText = event.endTimeText ?? ""
        self.eventDescription = event.eventDescription ?? ""
    }
}
