//
//  EventModel.swift
//  Eroute
//
//  Created by Mahendra on 28/12/21.
//  Copyright © 2021 Mahendra. All rights reserved.
//

import Foundation

struct EventModel {
    var id: UUID
    var name: String
    var dateText: String
    var startTimeText: String
    var endTimeText: String
    var eventNotes: String
    var eventVenue: String
    var createdAtTimeInterval : Int64
}

extension EventModel {
    init(from event: Event) {
        self.id = event.id ?? UUID()
        self.name = event.name ?? ""
        self.dateText = event.dateText ?? ""
        self.startTimeText = event.startTimeText ?? ""
        self.endTimeText = event.endTimeText ?? ""
        self.eventNotes = event.eventNotes ?? ""
        self.eventVenue = event.eventVenue ?? ""
        self.createdAtTimeInterval = event.createdAtTimeInterval
    }
}
