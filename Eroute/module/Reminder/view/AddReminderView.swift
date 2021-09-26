//
//  RemainderAddView.swift
//  Eroute
//
//  Created by bhavesh on 26/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct AddReminderView: View {

    @State private var reminderTime = Date()
    @State private var reminderLabel = ""
    @State private var reminderNote = ""
    @State private var isAlertPresented = false
    @Environment(\.presentationMode) var presentation

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
                    debugPrint("Save Button Clicked")
                    self.saveReminder()
                }) {
                    Text("Save")
                        .font(.title)
                }
                Spacer()
            }
        }.navigationBarTitle("Add Reminder", displayMode: .inline)
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text(""),
                      message: Text("Please Enter Reminder Label"),
                      dismissButton: .default(Text("OK"))
                )
        }
    }


    private func validateReminder() -> Bool {
        isAlertPresented = reminderLabel.isEmpty
        return !reminderLabel.isEmpty
    }

    private func saveReminder() {
        guard validateReminder() else { return }

        let dateTimeText = DateUtility.shared.getDateTimeText(from: reminderTime)
        let reminderModel = ReminderModel(id: UUID(),
                                          label: reminderLabel,
                                          note: reminderNote,
                                          dateTimeText: dateTimeText,
                                          isCompleted: false)

        ReminderCoreDataAction.shared.saveReminder(with: reminderModel)
        moveBack()
    }

    private func moveBack() {
        self.presentation.wrappedValue.dismiss()
    }
}
