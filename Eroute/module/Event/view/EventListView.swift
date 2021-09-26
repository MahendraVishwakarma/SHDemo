//
//  EventListView.swift
//  Eroute
//
//  Created by bhavesh on 26/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct EventListView: View {

    @State private var eventList: [EventModel] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(eventList, id: \.id) { item in
                    EventCardView(event: item)
                }
            }
            .onAppear {
                self.fetchEvents()
            }
            .navigationBarTitle(Text("Event").foregroundColor(Color.orange))
            .navigationBarItems(trailing: Button(action: {}) {
                NavigationLink(destination: AddEventView(), label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(Color.orange)
                })
            })
        }
    }

    private func fetchEvents() {

        EventCoreDataAction.shared.fetchEvents { result in
            switch result {
            case .success(let value):
                self.eventList = value
            case .failure(let error):
                debugPrint("Data is failure to access\(error.localizedDescription)")
            }
        }
    }
}

