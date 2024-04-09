//
//  AddNewTaskViewModel.swift
//  ToDoList
//
//  Created by Yaroslav Shchudlyk on 19.03.2024.
//

import Foundation

class AddNewTaskViewModel {
    func addTask(name: String, dueOn: Date) {
        CoreDataManager.shared.addNewTask(name: name, dueOn: dueOn)
    }
}
