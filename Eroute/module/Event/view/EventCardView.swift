//
//  EventCardView.swift
//  Eroute
//
//  Created by bhavesh on 26/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct EventCardView: View {

    var event: EventModel

    var body: some View {

        NavigationLink(destination: EditEventView(event)) {
            VStack(alignment: .leading) {

                HStack(alignment: .top) {
                    Text(event.name)
                        .font(.title)
                }

                HStack(alignment: .top) {
                    Text("Description: ")
                        .font(.subheadline)
                        .foregroundColor(Color.black.opacity(0.7))
                        +
                        Text(event.eventDescription)

                }
                HStack(alignment: .top) {
                    Text("Date: ")
                        .font(.subheadline)
                        .foregroundColor(Color.black.opacity(0.7))
                        +
                        Text(event.dateText)
                }
                HStack(alignment: .top) {
                    Text("Start Time: ")
                        .font(.subheadline)
                        .foregroundColor(Color.black.opacity(0.7))
                        +
                        Text(event.startTimeText)
                }
                HStack(alignment: .top) {
                    Text("End Time: ")
                        .font(.subheadline)
                        .foregroundColor(Color.black.opacity(0.7))
                        +
                        Text(event.endTimeText)
                }

//                HStack(alignment: .top) {
//                    Spacer()
//                    Text("View Invite List").foregroundColor(Color.orange)
//                        .onTapGesture {
//                            debugPrint("Invite List is called")
//                    }
//                }
            }
        }
    }
}
