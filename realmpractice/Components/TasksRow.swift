//
//  TasksRow.swift
//  realmpractice
//
//  Created by Charles Salgado on 12/18/22.
//

import SwiftUI

struct TasksRow: View {
    var task: String
    var completed: Bool
    
    var body: some View {
        HStack(spacing: 20) { //horizontal based arrangement
            Image(systemName: completed ? "checkmark.circle" : "circle")//image changes based on boolean check
            Text(task)
        }
    }
}

struct TasksRow_Previews: PreviewProvider {
    static var previews: some View {
        TasksRow(task: "Watch swift videos", completed: true)
    }
}
