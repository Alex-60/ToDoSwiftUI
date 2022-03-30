//
//  ListTasksView.swift
//  ToDoSwiftUI
//
//  Created by Alexandre Legros on 28/03/2022.
//

import SwiftUI

struct ListTasksView: View {
    @Binding var managerTask: TaskManager

    var body: some View {
        NavigationView {
            List(managerTask.taskList) { task in
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(task.taskName)
                        let dateCreated = task.dateFormated(dateOfTask: task.createdDate)
                        Text("Crée le \(dateCreated)")
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                    }
                    Spacer()
                    Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                        .font(.system(size: 30))
                        .foregroundStyle(.black, .blue , .yellow)
                }
                .onTapGesture {
                    checkOrUncheckTask(task)
                }
            }
            .navigationTitle(managerTask.taskList.isEmpty ? "Aucune tâche" : "\(managerTask.taskList.count) \(managerTask.taskList.count > 1 ? "tâches" : "tâche")")
        }
    }
    
    func checkOrUncheckTask(_ task: Tasks) {
        managerTask.toggleTasktatus(task: task)
    }

}

struct ListTasksView_Previews: PreviewProvider {
    static var previews: some View {
        ListTasksView(managerTask: .constant(TaskManager()))
            .previewLayout(.sizeThatFits)
    }
}
