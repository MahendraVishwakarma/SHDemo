//
//  EditReminderView.swift
//  Eroute
//
//  Created by bhavesh on 26/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct EditReminderView: View {

    private var reminder: ReminderModel
    
    @State private var reminderTime = Date()
    @State private var reminderLabel = ""
    @State private var reminderNote = ""
    @State private var isAlertPresented = false
    @Environment(\.presentationMode) var presentation


    init(_ reminder: ReminderModel) {
        self.reminder = reminder
        let date = DateUtility.shared.getDateFromDateTimeText(from: reminder.dateTimeText)
        self._reminderLabel = State(initialValue: reminder.label)
        self._reminderNote = State(initialValue: reminder.note)
        self._reminderTime = State(initialValue: date)
    }

    var body: some View {
        Form {
            DatePicker(selection: $reminderTime) {
                Text("Reminder Time: ")
            }
            TextField("Label", text: $reminderLabel)
            TextField("Note", text: $reminderNote)
            HStack {
                Spacer()
                Button(action: {
                    debugPrint("udpate Button Clicked")
                    self.updateReminder()
                }) {
                    Text("Save")
                        .font(.title)
                }
                Spacer()
            }
        }.navigationBarTitle("Edit Reminder", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.removeReminder()
            }, label: {
                Image(systemName: "trash")
            }))
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text(""), message: Text("Please Enter Label, It is mandatory"), dismissButton: .default(Text("OK")
                    .foregroundColor(Color.orange)))
        }
    }

    private func validateReminder() -> Bool {
        isAlertPresented = reminderLabel.isEmpty
        return !reminderLabel.isEmpty
    }

    private func updateReminder() {
        guard validateReminder() else { return }

        let dateTimeText = DateUtility.shared.getDateTimeText(from: reminderTime)
        let reminderModel = ReminderModel(id: reminder.id,
                                          label: reminderLabel,
                                          note: reminderNote,
                                          dateTimeText: dateTimeText,
                                          isCompleted: reminder.isCompleted)
        ReminderCoreDataAction.shared.updateReminder(with: reminderModel) { success in
            if success {
                debugPrint("Reminder successfully updated")
                self.moveBack()
            } else {
                debugPrint("error occur during updating Reminder")
            }
        }
    }

    private func removeReminder() {
        ReminderCoreDataAction.shared.removeReminder(with: self.reminder) { success in
            if success {
                debugPrint("Reminder successfully Removed")
                self.moveBack()
            } else {
                debugPrint("error occur during removing Reminder")
            }
        }
    }

    private func moveBack() {
        self.presentation.wrappedValue.dismiss()
    }
}
