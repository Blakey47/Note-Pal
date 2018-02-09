//
//  TaskController.swift
//  Note Pal
//
//  Created by Darragh on 2/3/18.
//  Copyright © 2018 Darragh. All rights reserved.
//

import UIKit
import CoreData

class TaskController: UITableViewController, CreateTaskControllerDelegate {    
    
    var category: Category?
    var tasks = [Task]()
    let cellId = "cellId"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = category?.name
    }
    
    private func fetchTasks() {
        guard let categoryTasks = category?.tasks?.allObjects as? [Task] else { return }
        self.tasks = categoryTasks
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let task = tasks[indexPath.row]
        let expandMenuButton = UIButton(type: .system)
        expandMenuButton.setTitle("Expand", for: .normal)
        expandMenuButton.translatesAutoresizingMaskIntoConstraints = false
        expandMenuButton.tintColor = .darkPurple
        expandMenuButton.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        
        cell.addSubview(expandMenuButton)
        expandMenuButton.rightAnchor.constraint(equalTo: cell.rightAnchor, constant: -8).isActive = true
        expandMenuButton.topAnchor.constraint(equalTo: cell.topAnchor, constant: 8).isActive = true
        expandMenuButton.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -8).isActive = true
        
        if let name = task.name, let _ = task.taskInformation?.dueDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE, dd MMM"
            let dueDateString = "\(name)"
            // - \(dateFormatter.string(from: dueDate))
            cell.textLabel?.text = dueDateString
            cell.imageView?.image = #imageLiteral(resourceName: "ic_list")
            cell.imageView?.tintColor = .darkPurple
        } else {
            cell.textLabel?.text = task.name
        }
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        fetchTasks()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        setupPlusButtonInNavBar(selector: #selector(handleAdd))
        tableView.separatorColor = .clear
    }
    
    func didAddTask(task: Task) {
        tasks.append(task)
        tableView.reloadData()
    }
    
    func didAddTaskInformation(taskInformation: TaskInformation) {
        
    }
    
    @objc private func handleAdd() {
        let createTaskController = CreateTaskController()
        createTaskController.delegate = self
        createTaskController.category = category
        let navController = CustomNavigationController(rootViewController: createTaskController)
        present(navController, animated: true, completion: nil)
    }
    
    @objc private func handleExpandClose() {
        print("Trying to expand and close task....")
    }
    
}
