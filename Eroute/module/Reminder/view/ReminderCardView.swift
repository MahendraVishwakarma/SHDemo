//
//  ReminderCardView.swift
//  Eroute
//
//  Created by bhavesh on 24/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct ReminderCardView: View {

    private var reminder: ReminderModel
    private var toggleClosure: (() -> Void)?

    init(_ reminder: ReminderModel, toggleClosure: (() -> Void)?) {
        self.reminder = reminder
        self.toggleClosure = toggleClosure
    }

    var body: some View {
        NavigationLink(destination: EditReminderView(reminder)){
            HStack(alignment: .firstTextBaseline) {

                Image(systemName: self.reminder.isCompleted ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(self.reminder.isCompleted ? Color.orange : Color.gray)
                    .font(.title)
                    .onTapGesture {
                        debugPrint("Cicle button is called")
                        self.toggleClosure?()
                }

                VStack(alignment: .leading, spacing: 0) {
                    Text(reminder.label)
                        .font(.title)
                        .foregroundColor(Color.black)

                    Text(reminder.dateTimeText)
                        .foregroundColor(Color.black.opacity(0.7))

                    Text(reminder.note.isEmpty ? "" : "Note: \(reminder.note)")
                        .foregroundColor(Color.black.opacity(0.7))
                }
            }
        }
    }
}
