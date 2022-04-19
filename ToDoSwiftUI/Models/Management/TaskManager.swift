//
//  TaskManager.swift
//  ToDoSwiftUI
//
//  Created by Alexandre Legros on 29/03/2022.
//

import Foundation

struct TaskManager {
    var taskList: [Tasks]
    let storage : CoreDataStorage = CoreDataStorage()

    init() {
        taskList = storage.fetchaskList()
    }

    @discardableResult
    mutating func addTask(withName taskName: String) -> Tasks {
        let newTask = Tasks(taskName: taskName)
        taskList.append(newTask)
        storage.addNewTask(task: newTask)
        return newTask
    }

    mutating func toggleTasktatus(task: Tasks) {
        if let indexTask = taskList.firstIndex(where: { (t) -> Bool in t.id == task.id }) {
            taskList[indexTask].isDone.toggle()
            storage.updateask(task: taskList[indexTask])
        }
    }

    mutating func removeAllTasks() {
        if !taskList.isEmpty {
            taskList.removeAll()
            storage.removeAll(tasks: taskList)
        }
    }
}
