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
    }
    
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
