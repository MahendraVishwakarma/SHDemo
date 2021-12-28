//
//  EventListView.swift
//  Eroute
//
//  Created by Mahendra on 28/12/21.
//  Copyright © 2021 Mahendra. All rights reserved.
//

import SwiftUI

struct EventListView: View {
    
    @State private var listSectionEvent: [EventSectionModel] = []
    
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                
                List {
                    
                    ForEach(listSectionEvent, id: \.id) { sectionEvent in
                        Section(header: Text(sectionEvent.eventSectionDateText).italic()) {
                            ForEach(sectionEvent.eventList, id: \.id) { item in
                                EventCardView(event: item)
                            }
                        }
                    }
                    
                }.onAppear {
                    self.fetchEvents()
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Main Events")
                
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
                createEventSectionModel(from: value)
            case .failure(let error):
                debugPrint("Data is failure to access\(error.localizedDescription)")
            }
        }
    }
    
    private func createEventSectionModel(from eventList: [EventModel]) {
        
        let eventListFilter = eventList.filter{ !$0.dateText.isEmpty }
        
        // grouped events on the baisc of EventDateText
        var dict: [String:[EventModel]] = [:]
        for eventModel in eventListFilter {
            if dict[eventModel.dateText] != nil {
                dict[eventModel.dateText]?.append(eventModel)
            } else {
                dict[eventModel.dateText] = [eventModel]
            }
        }
        
        /// Create event Section model from Dict to display into List
        var listEventSectionModel = [EventSectionModel]()
        for (key,value) in dict {
            
            let eventSectionDate = DateUtility.shared.getDate(from: key)
            
            let eventSectionDateText = DateUtility.shared.getEventSectionDateText(from: eventSectionDate)
            
            let eventSectionModel = EventSectionModel(id: UUID(),
                                                      eventSectionDate: eventSectionDate,
                                                      eventSectionDateText: eventSectionDateText,
                                                      eventList: value)
            listEventSectionModel.append(eventSectionModel)
        }
        
        
        /// Sort listEventSectionModel on the basic of date of section header
        let sortedSectionEvents = listEventSectionModel.sorted(by: {$0.eventSectionDate.timeIntervalSince1970 < $1.eventSectionDate.timeIntervalSince1970})
        
        
        self.listSectionEvent = sortedSectionEvents
        
    }
}

