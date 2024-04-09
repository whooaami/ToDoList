//
//  CoreDataManager.swift
//  ToDoList
//
//  Created by Yaroslav Shchudlyk on 19.03.2024.
//

import CoreData
import Foundation

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDo")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Error saving the staged changes \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getAll() -> [Task] {
        var tasks = [Task]()
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let sortByDueDate = NSSortDescriptor(key: "dueOn", ascending: true)
        fetchRequest.sortDescriptors = [sortByDueDate]
        do {
            tasks = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error \(error.localizedDescription)")
        }
        
        return tasks
    }
    
    func addNewTask(name: String, dueOn: Date) {
        let task = Task(context: context)
        task.name = name
        task.dueOn = dueOn
        
        task.id = UUID()
        task.completed = false
        task.completedOn = dueOn.advanced(by: 100_000)
        
        saveContext()
    }
    
    func toggleCompleted(id: UUID) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        let predicate = NSPredicate(format: "id=%@", id.uuidString)
        fetchRequest.predicate = predicate
        
        do {
//            let fetchedTasks = try context.fetch(fetchRequest)
//            for task in fetchedTasks {
//                task.completed = !task.completed
//                if task.completed {
//                    task.completedOn = Date()
//                }
//            }
            if let fetchedTask = try
                context.fetch(fetchRequest).first(where: { $0.id == id }) {
                fetchedTask.completed = !fetchedTask.completed
                if fetchedTask.completed {
                    fetchedTask.completedOn = Date()
                }
            }
            
            saveContext()
            
        } catch let error as NSError {
            print("Error toggling state: \(error.userInfo), \(error.localizedDescription)")
        }
    }
    
    func delete(id: UUID) {
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id=%@", id.uuidString)
        
        do {
            let fetchedTask = try context.fetch(fetchRequest)
            
            for task in fetchedTask {
                context.delete(task)
            }
            
            saveContext()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
}
