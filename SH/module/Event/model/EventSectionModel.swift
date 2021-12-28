//
//  EventSectionModel.swift
//  Eroute
//
//  Created by Mahendra on 28/12/21.
//  Copyright © 2021 Mahendra. All rights reserved.
//

import Foundation

struct EventSectionModel {
    var id: UUID
    var eventSectionDate: Date
    var eventSectionDateText: String
    var eventList: [EventModel]
}
