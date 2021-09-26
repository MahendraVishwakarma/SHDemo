//
//  EditAlarmView.swift
//  Eroute
//
//  Created by bhavesh on 25/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct EditAlarmView: View {

    private var alarm: AlarmModel

    @State private var alarmTime = Date()
    @State private var alarmLabel = ""
    @State private var isSnooze = true
    @State private var selectedRepeat = RepeatValue.never
    @State private var repeatList: [RepeatValue] = [.daily, .weekly, .weekend, .never]
    @Environment(\.presentationMode) var presentation

    init(_ alarm: AlarmModel) {
        self.alarm = alarm
        let date = DateUtility.shared.getDateFrom12HourTime(from: alarm.dateText)
        self._alarmTime = State(initialValue: date)
        self._alarmLabel = State(initialValue: alarm.label)
        self._isSnooze = State(initialValue: alarm.isSnooze)
        self._selectedRepeat = State(initialValue: RepeatValue(rawValue: alarm.repeatValue) ?? RepeatValue.never)
    }

    var body: some View {
        Form {
            DatePicker(selection: $alarmTime, displayedComponents: .hourAndMinute) {
                Text("Alarm Time: ")
            }
            TextField("Label", text: $alarmLabel)
            Picker(selection: $selectedRepeat, label: Text("Repeat")) {
                ForEach(repeatList, id: \.self) { value in
                    Text(value.text)
                }
            }
            
            Toggle(isOn: $isSnooze) {
                Text("Snooze")
            }
            
            HStack {
                Spacer()
                Button(action: {
                    debugPrint("Update Button Clicked")
                    self.updateAlarm()
                }) {
                    Text("Update")
                        .font(.title)
                }
                Spacer()
            }
        }.navigationBarTitle("Edit Alarm", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                self.removeAlarm()
            }, label: {
                Image(systemName: "trash")
            }))
    }

    private func updateAlarm() {

        let dateText = DateUtility.shared.getTimeIn12HourFormat(from: alarmTime)
        let alarmModel = AlarmModel(label: alarmLabel,
                                    dateText: dateText,
                                    isSnooze: isSnooze,
                                    id: alarm.id,
                                    repeatValue: selectedRepeat.rawValue)

        AlarmCoreDataAction.shared.updateAlarm(with: alarmModel) { success in

            if success {
                debugPrint("alarm successfully updated")
                self.moveBack()
            } else {
                debugPrint("error occur during updating alarm")
            }

        }
    }

    private func removeAlarm() {
        AlarmCoreDataAction.shared.removeAlarm(with: self.alarm) { success in
            if success {
                debugPrint("Alarm successfully removed")
                self.moveBack()
            } else {
                debugPrint("error occured during removing of alarm")
            }
        }
    }

    private func moveBack() {
        self.presentation.wrappedValue.dismiss()
    }
}
