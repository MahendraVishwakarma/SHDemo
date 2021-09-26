//
//  EditEventView.swift
//  Eroute
//
//  Created by bhavesh on 26/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct EditEventView: View {

    private var event: EventModel

    @State private var eventName = ""
    @State private var eventDescription = ""
    @State private var eventDate = Date()
    @State private var eventStartTime = Date()
    @State private var eventEndTime = Date()
    @State private var isAlertPresented = false
    @State private var errorText = ""
    @Environment(\.presentationMode) var presentation

    init(_ event: EventModel) {
        self.event = event
        self._eventName = State(initialValue: event.name)
        self._eventDescription = State(initialValue: event.eventDescription)
        let date = DateUtility.shared.getDateFromDateText(from: event.dateText)
        let startTime = DateUtility.shared.getEventTime12HourDate(from: event.dateText,
                                                                  hourTimeText: event.startTimeText)
        let endTime = DateUtility.shared.getEventTime12HourDate(from: event.dateText,
                                                                hourTimeText: event.endTimeText)
        self._eventDate = State(initialValue: date)
        self._eventStartTime = State(initialValue: startTime)
        self._eventEndTime = State(initialValue: endTime)
    }

    var body: some View {
        Form {

            TextField("Name", text: $eventName)

            TextField("Description", text: $eventDescription)

            DatePicker(selection: $eventDate, displayedComponents: .date) {
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
                    self.updateEvent()
                }) {
                    Text("Update")
                        .font(.title)
                }
                Spacer()
            }
        }.navigationBarTitle("Edit Event", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.removeEvent()
            }, label: {
                Image(systemName: "trash")
            }))
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

    private func updateEvent() {
        guard validateEvent() else {
            isAlertPresented = true
            return
        }

        let dateText = DateUtility.shared.getOnlyDateText(from: eventDate)
        let startTimeText = DateUtility.shared.getTimeIn12HourFormat(from: eventStartTime)
        let endTimeText = DateUtility.shared.getTimeIn12HourFormat(from: eventEndTime)

        let eventModel = EventModel(id: event.id,
                                    name: eventName,
                                    dateText: dateText,
                                    startTimeText: startTimeText,
                                    endTimeText: endTimeText,
                                    eventDescription: eventDescription)

        EventCoreDataAction.shared.updateEvent(with: eventModel) { success in
            if success {
                debugPrint("Event successfully updated")
                self.moveBack()
            } else {
                debugPrint("error occur during updating Event")
            }
        }
    }

    private func removeEvent() {
          EventCoreDataAction.shared.removeEvent(with: self.event) { success in
              if success {
                  debugPrint("Event successfully Removed")
                  self.moveBack()
              } else {
                  debugPrint("error occur during removing Event")
              }
          }
      }

    private func moveBack() {
        self.presentation.wrappedValue.dismiss()
    }
}
