//
//  TaskListViewModel.swift
//  ToDoList
//
//  Created by Yaroslav Shchudlyk on 19.03.2024.
//

import Foundation

class TaskListViewModel {
    var tasks = [TaskViewModel]()
    
    init() {
        getAll()
    }
    
    var numberOfTasks: Int {
        tasks.count
    }
    
    func getAll() {
        tasks = CoreDataManager.shared.getAll().map(TaskViewModel.init)
    }
    
    func numberOfRows(by section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return numberOfTasks
    }
    
    func getTaskByType() -> (complete: Int, incomplete: Int) {
        let completedCount = tasks.lazy.filter({ $0.completed }).count
        let incompleteCount = tasks.lazy.filter({ !$0.completed }).count
        
        return (completedCount, incompleteCount)
    }
    
    func task(by index: Int) -> TaskViewModel {
        tasks[index]
    }
    
    func toggleCompleted(task: TaskViewModel) {
        CoreDataManager.shared.toggleCompleted(id: task.id)
        getAll()
    }
    
    func deleteItem(task: TaskViewModel) {
        CoreDataManager.shared.delete(id: task.id)
        getAll()
    }
}
