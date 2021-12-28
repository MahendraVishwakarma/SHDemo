//
//  ContentView.swift
//  Eroute
//
//  Created by Mahendra on 28/12/21.
//  Copyright © 2021 Mahendra. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    init() {
        initialThemeSetup()
    }

    private func initialThemeSetup() {

        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: ColorUtility.themeUIColor]

        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: ColorUtility.themeUIColor]

        UITableView.appearance().backgroundColor = .clear

        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))

        UITableView.appearance().tableFooterView = UIView()

        UISwitch.appearance().onTintColor = ColorUtility.themeUIColor

        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = ColorUtility.themeUIColor
        
        UITableView.appearance().separatorStyle = .none
        
        UITableView.appearance().separatorColor = UIColor.clear
        
        UIToolbar.appearance().barTintColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1.0)
        
        
    }
    
    var body: some View {
        
        TabView {
            EventListView()
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                            .font(.title)
                        Text("Main Event")
                    }
            }.tag(0)

            UnspecifiedEventListView()
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                            .font(.title)
                        Text("Unspecified Event")
                    }
            }.tag(1)
            
        }.accentColor(ColorUtility.themeColor)
    }
}

