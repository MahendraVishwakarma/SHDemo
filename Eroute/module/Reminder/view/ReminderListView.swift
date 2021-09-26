//
//  ReminderListView.swift
//  Eroute
//
//  Created by bhavesh on 24/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct ReminderListView: View {

    @State private var reminderList: [ReminderModel] = []
   
    var body: some View {
        NavigationView {
            List {
                ForEach(reminderList, id: \.id) { reminder in
                    ReminderCardView(reminder) {
                        self.toggleReminder(with: reminder)
                    }
                }
            }
            .onAppear {
                self.fetchReminders()
            }
            .navigationBarTitle(Text("Reminder").foregroundColor(Color.orange))
            .navigationBarItems(trailing: Button(action: {}) {
                NavigationLink(destination: AddReminderView(), label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(Color.orange)
                })
            })
        }
    }

    private func fetchReminders() {

        ReminderCoreDataAction.shared.fetchReminders { result in
            switch result {
            case .success(let value):
                self.reminderList = value
            case .failure(let error):
                debugPrint("Data is failure to access\(error.localizedDescription)")
            }
        }
    }

    private func toggleReminder(with model: ReminderModel) {
        ReminderCoreDataAction.shared.toggleReminder(with: model) { success in
            if success  {
                self.fetchReminders()
            }
        }
    }
}

struct ReminderListView_Previews: PreviewProvider {
    static var previews: some View {
        ReminderListView()
    }
}
