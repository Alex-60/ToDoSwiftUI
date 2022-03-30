//
//  CoreDataStorage.swift
//  ToDoSwiftUI
//
//  Created by Alexandre Legros on 29/03/2022.
//

import Foundation
import CoreData

class CoreDataStorage {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()

    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func fetchaskList() -> [Tasks] {
        let tasksList: [Tasks]
        let fetchRequest: NSFetchRequest<CDTasks> = CDTasks.fetchRequest()
        if let rawTasksList = try? context.fetch(fetchRequest) {
            tasksList = rawTasksList.compactMap({ (rawTasks: CDTasks) -> Tasks? in
                Tasks(fromCoreDataObject: rawTasks)
            })
        } else {
            tasksList = []
        }
            
        return tasksList
    }

    func addNewTask(task: Tasks) {
        let newTask = CDTasks(context: context)
        newTask.id = task.id
        newTask.createdDate = task.createdDate
        newTask.taskName = task.taskName
        newTask.isDone = task.isDone
        saveData()
    }

    func updateask(task: Tasks) {
        if let existingTask = fetchCDTask(withID: task.id) {
            existingTask.taskName = task.taskName
            existingTask.isDone = task.isDone
            saveData()
        }
    }

    func removeAll(tasks: [Tasks]) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDTasks")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Une erreur est survenue lors de la suppression des tasks en base. Error \(error.localizedDescription)")
        }
    }

    private func fetchCDTask(withID taskID: UUID) -> CDTasks? {
        let fetchRequest: NSFetchRequest<CDTasks> = CDTasks.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", taskID as CVarArg)
        fetchRequest.fetchLimit = 1
        let fetchResult: [CDTasks]? = try? context.fetch(fetchRequest)
        return fetchResult?.first
    }

    private func saveData() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Une erreur est survenu lors de la sauvegarde : \(error.localizedDescription)")
            }
        }
    }

}

extension Tasks {
    init?(fromCoreDataObject coreDataObjet: CDTasks) {
        guard let id = coreDataObjet.id,
              let taskName = coreDataObjet.taskName,
              let createdDate = coreDataObjet.createdDate else {
            return nil
        }
        self.id = id
        self.taskName = taskName
        self.createdDate = createdDate
        self.isDone = coreDataObjet.isDone
    }
}
