//
//  AlaramView.swift
//  Eroute
//
//  Created by bhavesh on 24/09/21.
//  Copyright © 2021 Bhavesh. All rights reserved.
//

import SwiftUI

struct AlarmListView: View {
    
    @State var alarmsList: [AlarmModel] = []
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(alarmsList, id: \.id) { alaram in
                    AlarmCardView(alaram)
                }
            }
            .onAppear {
                self.fetchAlarms()
            }
            .navigationBarTitle("Alarm")
            .navigationBarItems(trailing: Button(action: {}) {

                NavigationLink(destination: AddAlarmView(), label: {
                    Image(systemName: "plus")
                        .font(.title)
                        .foregroundColor(Color.orange)
                })
            })
            
        }
    }
    
    private func fetchAlarms() {
        AlarmCoreDataAction.shared.fetchAlarms { result in
            switch result {
            case .success(let value):
                self.alarmsList = value
            case .failure(let error):
                debugPrint("Data is failure to access\(error.localizedDescription)")
            }
        }
    }
    
}

struct AlaramView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView()
    }
}
