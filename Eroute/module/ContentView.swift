//
//  ContentView.swift
//  Eroute
//
//  Created by bhavesh on 24/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.lightGray
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.orange]
        
        UITableView.appearance().backgroundColor = .clear
        
        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        
        UITableView.appearance().tableFooterView = UIView()
        
        UISwitch.appearance().onTintColor = UIColor.orange
        
    }
    
    var body: some View {
        
        TabView {
            
            ReminderListView()
                .tabItem {
                    HStack {
                        Image(systemName: "bell.fill")
                            .font(.title)
                        Text("Reminder")
                        
                    }
                    
            }
            .tag(0)
            
            AlarmListView()
                .tabItem {
                    HStack {
                        Image(systemName: "calendar")
                            .font(.title)
                        Text("Event")
                        
                    }
                    
            }
            .tag(1)
            
            AlarmListView()
                .tabItem {
                    HStack {
                        Image(systemName: "alarm.fill")
                            .font(.title)
                        Text("Alarm")
                        
                    }
                    
            }
            .tag(2)
            
            
        }.accentColor(Color.orange)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
