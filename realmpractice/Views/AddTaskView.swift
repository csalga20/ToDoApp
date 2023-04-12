//
//  AddTaskView.swift
//  realmpractice
//
//  Created by Charles Salgado on 12/18/22.
//

import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var realmManager: RealmManager
    //private keeps it from getting changed anywhere else
    @State private var title: String = ""
    
    //aallows us to dismiss a view
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Create new task")
                .font(.title3).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            TextField("Enter your task here", text: $title)
                .textFieldStyle(.roundedBorder)
            Button {
                //test: print("Tasks added")
                //make sure title is not blank
                if title != ""
                {
                    realmManager.addTask(taskTitle: title)
                }
                dismiss()
            } label: {
                Text("Add Tasks")
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color(hue: 0.328, saturation: 0.796, brightness: 0.408))
                    .cornerRadius(30) //rounds the corners of the button
            }
            //pushes everything to the bottom to take up entire screen
            Spacer()
        }
        .padding(.top, 40)
        .padding(.horizontal)
        .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        //initializes realm manager for the preview
        AddTaskView().environmentObject(RealmManager())
    }
}
