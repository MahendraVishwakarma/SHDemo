//
//  AddAlarmView.swift
//  Eroute
//
//  Created by bhavesh on 24/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct AddAlarmView: View {

    @State private var alarmTime = Date()
    @State private var alarmLabel = ""
    @State private var isSnooze = true
    @State private var selectedRepeat = RepeatValue.never
    @State private var repeatList: [RepeatValue] = [.daily, .weekly, .weekend, .never]
    @Environment(\.presentationMode) var presentation

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
                    debugPrint("Save Button Clicked")
                    self.saveAlarm()
                }) {
                    Text("Save")
                        .font(.title)
                }
                Spacer()
            }
        }.navigationBarTitle("Add Alarm", displayMode: .inline)
    }

    private func saveAlarm() {

        let dateText = DateUtility.shared.getTimeIn12HourFormat(from: alarmTime)
        let alarmModel = AlarmModel(label: alarmLabel,
                                    dateText: dateText,
                                    isSnooze: isSnooze,
                                    id: UUID(),
                                    repeatValue: selectedRepeat.rawValue)

        AlarmCoreDataAction.shared.saveAlarm(with: alarmModel)
        moveBack()
    }

    private func moveBack() {
        self.presentation.wrappedValue.dismiss()
    }
}
