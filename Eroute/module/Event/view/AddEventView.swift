//
//  AddEventView.swift
//  Eroute
//
//  Created by bhavesh on 26/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct AddEventView: View {

    @State private var eventName = ""
    @State private var eventDescription = ""
    @State private var eventDate = Date()
    @State private var eventStartTime = Date()
    @State private var eventEndTime = Date()
    @State private var isAlertPresented = false
    @State private var errorText = ""

    @Environment(\.presentationMode) var presentation

    var body: some View {
        Form {

            TextField("Name", text: $eventName)

            TextField("Description", text: $eventDescription)

            DatePicker(selection: $eventDate, in: Date()..., displayedComponents: .date) {
                Text("Event Date: ")
            }

            DatePicker(selection: $eventStartTime, displayedComponents: .hourAndMinute) {
                Text("Event Start Time: ")
            }

            DatePicker(selection: $eventEndTime, displayedComponents: .hourAndMinute) {
                Text("Event End Time: ")
            }

            HStack {
                Spacer()
                Button(action: {
                    debugPrint("Save Button Clicked")
                    self.saveEvent()
                }) {
                    Text("Save")
                        .font(.title)
                }
                Spacer()
            }
        }.navigationBarTitle("Add Event", displayMode: .inline)
            .alert(isPresented: $isAlertPresented) {
                Alert(title: Text(""),
                      message: Text(errorText),
                      dismissButton: .default(Text("OK"))
                )
        }
    }

    private func validateEvent() -> Bool {
        guard !eventName.isEmpty else {
            errorText = "Please Enter Event Name"
            debugPrint("Event Name should not be Empty")
            return false
        }

        guard !eventDescription.isEmpty else {
            errorText = "Please Enter Event Description"
            debugPrint("Event Description should not be Empty")
            return false
        }

        guard eventStartTime < eventEndTime else {
            errorText = "Event Start Time should be less than Event End time"
            debugPrint("Event start time should be less than Event end time")
            return false
        }

        errorText = ""
        return true
    }

    private func saveEvent() {
        guard validateEvent() else {
            isAlertPresented = true
            return
        }

        let dateText = DateUtility.shared.getOnlyDateText(from: eventDate)
        let startTimeText = DateUtility.shared.getTimeIn12HourFormat(from: eventStartTime)
        let endTimeText = DateUtility.shared.getTimeIn12HourFormat(from: eventEndTime)
        let eventModel = EventModel(id: UUID(),
                                    name: eventName,
                                    dateText: dateText,
                                    startTimeText: startTimeText,
                                    endTimeText: endTimeText,
                                    eventDescription: eventDescription)

        EventCoreDataAction.shared.saveEvent(with: eventModel)
        moveBack()
    }

    private func moveBack() {
        self.presentation.wrappedValue.dismiss()
    }
}
