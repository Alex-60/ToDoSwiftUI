//
//  AddTaskView.swift
//  ToDoSwiftUI
//
//  Created by Alexandre Legros on 28/03/2022.
//

import SwiftUI

struct AddTaskView: View {
    @State var taskToSave: String
    @Binding var managerTask: TaskManager

    var body: some View {
        VStack {
            HStack {
                TextField("Tâche à réaliser", text: $taskToSave)
                Image(systemName: "plus.circle")
                    .onTapGesture {
                        addnewTask(taskToAdd: taskToSave)
                    }
            }
            .padding()
            if !managerTask.taskList.isEmpty {
                Button("Effacer la liste", action: {
                    removeAllTask()
                })
            }
        }
        .padding()
    }

    func addnewTask(taskToAdd: String) {
        if !taskToSave.isEmpty {
            managerTask.addTask(withName: taskToAdd)
            taskToSave = ""
        }
    }

    func removeAllTask() {
        if !managerTask.taskList.isEmpty {
            managerTask.removeAllTasks()
        }
    }

}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView(taskToSave: "Finir cours", managerTask: .constant(TaskManager()))
    }
}
