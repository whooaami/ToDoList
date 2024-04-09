//
//  TaskViewModel.swift
//  ToDoList
//
//  Created by Yaroslav Shchudlyk on 19.03.2024.
//

import Foundation

struct TaskViewModel {
    private var task: Task
    
    init(task: Task) {
        self.task = task
    }
    
    var id: UUID {
        task.id ?? UUID()
    }
    
    var name: String {
        task.name ?? ""
    }
    
    var dueOn: Date {
        task.dueOn ?? Date()
    }
    
    var completedOn: Date {
        task.completedOn ?? Date()
    }
    
    var completed: Bool {
        task.completed
    }
}
