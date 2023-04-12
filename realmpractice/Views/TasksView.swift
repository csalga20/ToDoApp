//
//  TasksView.swift
//  realmpractice
//
//  Created by Charles Salgado on 12/18/22.
//

import SwiftUI
import RealmSwift

struct TasksView: View {
    @EnvironmentObject var realmManager: RealmManager
    //@ObservedResults(tasks.self) var otasks
    //@ObservedRealmObject var 
    
    var body: some View {
        VStack { //vertical based stack
            Text("Tasks To Do")
                .font(.title3).bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            //use list becaause we will be using a swipe action
            List {
                //iterate through task array from realm manager
                ForEach(realmManager.tasks, id: \.id) { task in
                    if !task.isInvalidated {
                        TasksRow(task: task.title, completed: task.completed)
                        //on tap, update task completed symbol
                            .onTapGesture {
                                realmManager.updateTask(id: task.id, completed: !task.completed)
                            }
                        
                        //delete a task with a swipe from right to left
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    DispatchQueue.main.async {
                                        realmManager.deleteTask(id: task.id)
                                    }
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
                .listRowSeparator(.hidden)
            }
            .onAppear {
                UIScrollView.appearance().backgroundColor = .clear
            }
            //.frame(maxWidth: 350)
            .scrollContentBackground(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        //initialize realm manager to preview
        TasksView().environmentObject(RealmManager())
    }
}
