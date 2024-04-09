//
//  ToDoListViewControllerDelegate.swift
//  ToDoList
//
//  Created by Yaroslav Shchudlyk on 20.03.2024.
//

import UIKit

extension ToDoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let task = viewModel.task(by: indexPath.row)
        
        let completeAction = UIContextualAction(style: .normal, title: task.completed ? "Not completed" : "Complete") { [weak self](action, view, completionHandler) in
            self?.completeTask(at: indexPath)
            
            completionHandler(true)
        }
        
        completeAction.backgroundColor = task.completed ? UIColor.systemRed : UIColor.systemGreen
        
        let configuration = UISwipeActionsConfiguration(actions: [completeAction])
        configuration.performsFirstActionWithFullSwipe = true
        
        return configuration
    }
    
    func completeTask(at indexPath: IndexPath) {
        let task = viewModel.task(by: indexPath.row)
        viewModel.toggleCompleted(task: task)
        
        if task.completed {
            celebrateAnimationView.isHidden = false
            celebrateAnimationView.play { finished in
                self.celebrateAnimationView.isHidden = finished
            }
        }
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadRows(at: [IndexPath.SubSequence(row: 0, section: 0)], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section != 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        let task = viewModel.task(by: indexPath.row)
        viewModel.deleteItem(task: task)
        tableView.reloadData()
    }
    
}
