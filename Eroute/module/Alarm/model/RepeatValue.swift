//
//  RepeatValue.swift
//  Eroute
//
//  Created by bhavesh on 25/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import Foundation

enum RepeatValue: Int {
    case daily = 0
    case weekly = 1
    case weekend = 2
    case never = 4
    
    var text: String {
        switch self {
            
        case .daily:
            return "Daily"
        case .weekly:
            return "Weekly"
        case .weekend:
            return "Weekend"
        case .never:
            return "Never"
        }
    }
}

