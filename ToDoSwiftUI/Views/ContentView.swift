//
//  ContentView.swift
//  ToDoSwiftUI
//
//  Created by Alexandre Legros on 28/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State var task: String
    @State var taskManager = TaskManager()

    var body: some View {
        AddTaskView(taskToSave: task, managerTask: $taskManager)
        ListTasksView(managerTask: $taskManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(task: "")
    }
}
