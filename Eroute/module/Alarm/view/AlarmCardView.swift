//
//  AlaramCard.swift
//  Eroute
//
//  Created by bhavesh on 24/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct AlarmCardView: View {

    private var alarm: AlarmModel

    init(_ alarm: AlarmModel) {
        self.alarm = alarm
    }

    var body: some View {
        NavigationLink(destination: EditAlarmView(alarm)){
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text(alarm.dateText)
                        .font(.largeTitle)
                        .foregroundColor(Color.black.opacity(0.7))
                    
                    if !alarm.label.isEmpty {
                        Text("Label: \(alarm.label)")
                    }
                    
                    HStack {
                        Text("Repeat: \((RepeatValue(rawValue: alarm.repeatValue) ?? RepeatValue.never).text)")
                        Spacer()
                        Text("Snooze: \( alarm.isSnooze ? "On" : "Off")")
                    }
                    
                }
            }
        }
    }
}

