//
//  UnspecifiedEventListView.swift
//  Eroute
//
//  Created by Mahendra on 28/12/21.
//  Copyright © 2021 Mahendra. All rights reserved.
//

import SwiftUI

struct UnspecifiedEventListView: View {
    
    @State private var listEvents: [EventModel] = []

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                List {
                    ForEach(listEvents, id: \.id) { item in
                        EventCardView(event: item)
                    }
                }
                .onAppear {
                        self.fetchEvents()
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Unspecified Events")
                
                Button(action: {}) {
                    NavigationLink(destination: AddEventView(), label: {
                        
                        Image(systemName: "plus")
                            .font(.title)
                            .foregroundColor(ColorUtility.themeColor)
                            .padding()
                            .background(ColorUtility.transparentGrayColor)
                            .clipShape(Circle())
                    })
                }.padding()
            }
        }
    }

    private func fetchEvents() {
        EventCoreDataAction.shared.fetchEvents { result in
            switch result {
            case .success(let value):
                createListForUnspecifiedEvents(from: value)
            case .failure(let error):
                debugPrint("Data is failure to access\(error.localizedDescription)")
            }
        }
    }
    
    private func createListForUnspecifiedEvents(from eventList: [EventModel]) {
        
        /// get filter Unspecified Events
        let filterUnspecifiedEvents = eventList.filter{ $0.dateText.isEmpty }
        
        /// sorted out unspecified events on the basic of created Event
        let sortedUnspecifedEvents = filterUnspecifiedEvents.sorted(by: {$0.createdAtTimeInterval < $1.createdAtTimeInterval})
        
        self.listEvents = sortedUnspecifedEvents
    }
}
