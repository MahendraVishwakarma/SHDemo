//
//  EventCardView.swift
//  Eroute
//
//  Created by Mahendra on 28/12/21.
//  Copyright © 2021 Mahendra. All rights reserved.
//

import SwiftUI

struct EventCardView: View {
    
    var event: EventModel
    
    var body: some View {
        
            HStack (alignment: .top) {
                VStack(alignment: .center) {
                    
                    Text(event.startTimeText)
                        .padding(EdgeInsets(top: 6.0, leading: 0, bottom: 0, trailing:0))
                    
                    if !event.endTimeText.isEmpty {
                        
                        Rectangle()
                            .frame(width: 1.0, height: 50, alignment: .center)
                            .foregroundColor(Color.gray)
                        
                        Text(event.endTimeText)
                    }
                }
                
                VStack(alignment: .leading) {
                    
                    HStack(alignment: .top) {
                        Text(event.name)
                            .font(.system(size: 24))
                            .bold()
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 6.0, trailing:0))
                    
                    
                    if !event.eventVenue.isEmpty {
                        HStack(alignment: .top) {
                            Text("@")
                                .font(.subheadline)
                                .foregroundColor(Color.black.opacity(0.7))
                                .frame(width: 45, height: 15, alignment: .leading)
                            
                            Text(event.eventVenue)
                                .underline()
                                .bold()
                        }
                    }
                    
                    if !event.eventNotes.isEmpty {
                        HStack(alignment: .top) {
                            Text("notes")
                                .font(.subheadline)
                                .foregroundColor(Color.black.opacity(0.7))
                                .frame(width: 45, height: 15, alignment: .leading)
                            
                            
                            Text(event.eventNotes)
                                .lineLimit(3)
                        }
                    }
                }
                
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .background(RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white)
                                .shadow(color: ColorUtility.shadowGrayColor, radius: 2, x: 0, y: 1))
    }
    
}
