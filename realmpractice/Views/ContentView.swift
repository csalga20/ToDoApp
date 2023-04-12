//
//  ContentView.swift
//  realmpractice
//
//  Created by Charles Salgado on 12/17/22.
//

import SwiftUI

struct ContentView: View {
    //realmManager() initializes class
    @StateObject var realmManager = RealmManager()
    //only accessible in this file
    @State private var showAddTaskView = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TasksView().environmentObject(realmManager)
            
            SmallAddButton()
                .padding()
                .onTapGesture {
                    showAddTaskView.toggle()
                }
        }
        .sheet(isPresented: $showAddTaskView){
            AddTaskView().environmentObject(realmManager)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
