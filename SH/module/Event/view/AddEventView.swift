//
//  AddEventView.swift
//  Eroute
//
//  Created by Mahendra on 28/12/21.
//  Copyright © 2021 Mahendra. All rights reserved.
//

import SwiftUI
import UIKit

struct AddEventView: View {
    
    @State private var eventName = ""
    @State private var eventVenue = ""
    @State private var eventNotes = ""
    @State private var eventDate = Date()
    @State private var eventStartTime = Date()
    @State private var eventEndTime = Date()
    @State private var isAlertPresented = false
    @State private var errorText = ""
    @State private var isEventStartTimeEndTime = false
    @State private var isEventDate = false
    @FocusState private var focus: FocusableField?
    
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        Form {
            
            TextField("Name\u{002A}", text: $eventName)
                .focused($focus, equals: .name)
            
            TextField("Venue @", text: $eventVenue)
                .focused($focus, equals: .venue)
            
            TextField("Notes", text: $eventNotes)
                .focused($focus, equals: .notes)
            
            Toggle("Event Date", isOn: $isEventDate)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            
            if isEventDate {
                DatePicker(selection: $eventDate, in: Date()..., displayedComponents: .date) {
                    Text("Select Event Date: ")
                }.focused($focus, equals: .date)
            }
            
            Toggle("Event Start Time and End Time", isOn: $isEventStartTimeEndTime)
                .toggleStyle(SwitchToggleStyle(tint: .accentColor))
            
            if isEventStartTimeEndTime {
                DatePicker(selection: $eventStartTime, displayedComponents: .hourAndMinute) {
                    Text("Select Event Start Time: ")
                }.focused($focus, equals: .startAndEndTime)
                
                DatePicker(selection: $eventEndTime, displayedComponents: .hourAndMinute) {
                    Text("Select Event End Time: ")
                }
            }
            
            HStack {
                Spacer()
                Button(action: {
                    debugPrint("Save Button Clicked")
                    self.saveEvent()
                }) {
                    Image(systemName: "checkmark")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .padding()
                        .clipShape(Circle())
                        .background(Circle()
                                        .fill(eventName.isEmpty ?
                                              ColorUtility.themeColor.opacity(0.5) : ColorUtility.themeColor)
                                        .shadow(color: ColorUtility.shadowGrayColor, radius: 2, x: 0, y: 1))
                }.disabled(eventName.isEmpty)
                Spacer()
            }
        }.toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    
                    Button {
                        focus = .name
                    } label: {
                        Text("Name")
                            .foregroundColor(ColorUtility.themeColor)
                            .padding(EdgeInsets(top: 2.0, leading: 4.0, bottom: 2.0, trailing: 4.0))
                            .background(RoundedRectangle(cornerRadius: 6)
                                            .fill(Color.white)
                                            .shadow(color: ColorUtility.shadowGrayColor, radius: 2, x: 0, y: 1))
                    }
                    
                    Button {
                        focus = .venue
                    } label: {
                        Text("Venue")
                            .foregroundColor(ColorUtility.themeColor)
                            .padding(EdgeInsets(top: 2.0, leading: 4.0, bottom: 2.0, trailing: 4.0))
                            .background(RoundedRectangle(cornerRadius: 6)
                                            .fill(Color.white)
                                            .shadow(color: ColorUtility.shadowGrayColor, radius: 2, x: 0, y: 1))
                    }
                    
                    Button {
                        focus = .notes
                    } label: {
                        Text("Notes")
                            .foregroundColor(ColorUtility.themeColor)
                            .padding(EdgeInsets(top: 2.0, leading: 4.0, bottom: 2.0, trailing: 4.0))
                            .background(RoundedRectangle(cornerRadius: 6)
                                            .fill(Color.white)
                                            .shadow(color: ColorUtility.shadowGrayColor, radius: 2, x: 0, y: 1))
                    }
                    
                    Button {
                        isEventDate = true
                        focus = .date
                        
                    } label: {
                        Text("Date")
                            .foregroundColor(ColorUtility.themeColor)
                            .padding(EdgeInsets(top: 2.0, leading: 4.0, bottom: 2.0, trailing: 4.0))
                            .background(RoundedRectangle(cornerRadius: 6)
                                            .fill(Color.white)
                                            .shadow(color: ColorUtility.shadowGrayColor, radius: 2, x: 0, y: 1))
                    }
                    
                    Button {
                        isEventStartTimeEndTime = true
                        focus = .startAndEndTime
                    } label: {
                        Text("Time")
                            .foregroundColor(ColorUtility.themeColor)
                            .padding(EdgeInsets(top: 2.0, leading: 4.0, bottom: 2.0, trailing: 4.0))
                            .background(RoundedRectangle(cornerRadius: 6)
                                            .fill(Color.white)
                                            .shadow(color: ColorUtility.shadowGrayColor, radius: 2, x: 0, y: 1))
                    }
                }
            }
        }
        .navigationBarTitle("Add Event", displayMode: .inline)
        .alert(isPresented: $isAlertPresented) {
            Alert(title: Text(""),
                  message: Text(errorText),
                  dismissButton: .default(Text("OK"))
            )
        }
    }
    
    private func validateEvent() -> Bool {
        if isEventStartTimeEndTime {
            guard eventStartTime < eventEndTime else {
                errorText = "Event End time should be greater than Event start time"
                debugPrint("Event End time should be greater than Event start time")
                return false
            }
        }
        errorText = ""
        return true
    }
    
    private func saveEvent() {
        guard validateEvent() else {
            isAlertPresented = true
            return
        }
        var dateText = ""
        var startTimeText =  ""
        var endTimeText = ""
        
        if isEventDate {
            dateText = DateUtility.shared.getDateText(from: eventDate)
        }
        
        if isEventStartTimeEndTime {
            startTimeText = DateUtility.shared.getTimeIn24HourFormat(from: eventStartTime)
            endTimeText = DateUtility.shared.getTimeIn24HourFormat(from: eventEndTime)
        }
        
        let createdAtTimeInterval = Date().currentTimeMillis()
        
        let eventModel = EventModel(id: UUID(),
                                    name: eventName,
                                    dateText: dateText,
                                    startTimeText: startTimeText,
                                    endTimeText: endTimeText,
                                    eventNotes: eventNotes,
                                    eventVenue: eventVenue,
                                    createdAtTimeInterval: createdAtTimeInterval)
        
        EventCoreDataAction.shared.saveEvent(with: eventModel)
        moveBack()
    }
    
    private func moveBack() {
        self.presentation.wrappedValue.dismiss()
    }
}

enum FocusableField: Hashable {
    case name
    case venue
    case notes
    case date
    case startAndEndTime
}
