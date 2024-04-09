//
//  ViewController.swift
//  ToDoList
//
//  Created by Yaroslav Shchudlyk on 19.03.2024.
//

import UIKit

class ToDoListViewController: UIViewController {
    
    let viewModel = TaskListViewModel()
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.dataSource = self
        v.delegate = self
        v.register(ToDoTableViewCell.self, forCellReuseIdentifier: "ToDoCell")
        v.register(SummaryTableViewCell.self, forCellReuseIdentifier: "SummaryCell")
        v.estimatedRowHeight = 200
        v.rowHeight = UITableView.automaticDimension
        return v
    }()
    
    lazy var celebrateAnimationView: CelebrationAnimationView = {
        let v = CelebrationAnimationView(fileName: "Animation - 1710966711685")
        v.translatesAutoresizingMaskIntoConstraints = false
        v.isHidden = true
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemBackground
        title = "Yarko's tasks"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTask))
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(celebrateAnimationView)
        NSLayoutConstraint.activate([
            celebrateAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            celebrateAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            celebrateAnimationView.topAnchor.constraint(equalTo: view.topAnchor),
            celebrateAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Temp code
//        view.addSubview(celebrateAnimationView)
//        NSLayoutConstraint.activate([
//            celebrateAnimationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            celebrateAnimationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            celebrateAnimationView.topAnchor.constraint(equalTo: view.topAnchor),
//            celebrateAnimationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        celebrateAnimationView.play { finished in
//            print("Done playing animation")
//        }
//    }
    
    @objc
    func addNewTask() {
        navigationController?.pushViewController(AddNewTaskViewController(), animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getAll()
        tableView.reloadData()
    }
}


// For reference only

//class ToDoListViewController: UIViewController {
//
//    lazy var addNewButton: UIButton = {
//        let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.setTitle("Add Task", for: .normal)
//        v.addTarget(self, action: #selector(addNewTask(sender:)), for: .touchUpInside)
//        return v
//    }()
//
//    lazy var getTasksButton: UIButton = {
//        let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.setTitle("Get Task", for: .normal)
//        v.addTarget(self, action: #selector(getTasks(sender:)), for: .touchUpInside)
//        return v
//    }()
//
//    lazy var toggleCompletedButton: UIButton = {
//        let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.setTitle("Yako Task Completed", for: .normal)
//        v.addTarget(self, action: #selector(yarkoCompleted(sender:)), for: .touchUpInside)
//        return v
//    }()
//
//    lazy var deleteTaskButton: UIButton = {
//        let v = UIButton()
//        v.translatesAutoresizingMaskIntoConstraints = false
//        v.setTitle("Delete Task", for: .normal)
//        v.addTarget(self, action: #selector(deleteTask(sender:)), for: .touchUpInside)
//        return v
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = UIColor.systemBackground
//        title = "Yarko's tasks"
//
//        // Add views
//        [addNewButton, getTasksButton, toggleCompletedButton, deleteTaskButton].forEach { control in
//            view.addSubview(control)
//        }
//
//        // Add constraints
//        NSLayoutConstraint.activate([
//            // Add new button
//            addNewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            addNewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            addNewButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//
//            // Get tasks
//            getTasksButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            getTasksButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            getTasksButton.topAnchor.constraint(equalTo: addNewButton.bottomAnchor, constant: 8),
//
//            // Toggle completed
//            toggleCompletedButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            toggleCompletedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            toggleCompletedButton.topAnchor.constraint(equalTo: getTasksButton.bottomAnchor, constant: 8),
//
//            // Delete task
//            deleteTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            deleteTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            deleteTaskButton.topAnchor.constraint(equalTo: toggleCompletedButton.bottomAnchor, constant: 8),
//        ])
//    }
//
//    @objc
//    func addNewTask(sender: UIButton) {
//        CoreDataManager.shared.addNewTask(name: "A new task", dueOn: Date().addingTimeInterval(100_000))
//    }
//
//    @objc
//    func getTasks(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//
//        for task in tasks {
//            print(task.name ?? "")
//        }
//    }
//
//    @objc
//    func yarkoCompleted(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            CoreDataManager.shared.toggleCompleted(id: task.id ?? UUID())
//        }
//
//        let fetchedTasks = CoreDataManager.shared.getAll()
//        for task in fetchedTasks {
//            print("\(task.name ?? ""): \(task.completed), \(task.completedOn?.formatted(date: .abbreviated, time: .omitted) ?? "")")
//        }
//    }
//
//    @objc
//    func deleteTask(sender: UIButton) {
//        let tasks = CoreDataManager.shared.getAll()
//        for task in tasks {
//            CoreDataManager.shared.delete(id: task.id ?? UUID())
//        }
//
//        let fetchedTasks = CoreDataManager.shared.getAll()
//        print(fetchedTasks.count)
//        for task in fetchedTasks {
//            print("\(task.name ?? ""): \(task.completed), \(task.completedOn?.formatted(date: .abbreviated, time: .omitted) ?? "")")
//        }
//    }
//
//}
